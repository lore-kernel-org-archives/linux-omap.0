From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
Date: Fri, 15 Nov 2013 08:39:46 -0600
Message-ID: <52863232.30207@ti.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com>	<CANacCWz_ahKaACbAHuue1XwaN3gutBA7Z6W+=zWBn8LvLwDM5w@mail.gmail.com>	<527A7E20.4040107@ti.com>	<527B95E3.9060802@ti.com>	<527B9673.60400@gmail.com>	<527BAF63.10308@ti.com>	<527BB38A.1060609@gmail.com>	<527BB636.60403@ti.com>
 <CANacCWynOaW_xDBCiFaG5vrcTFuOkk43kuu26gvN4-eN2E8R4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CANacCWynOaW_xDBCiFaG5vrcTFuOkk43kuu26gvN4-eN2E8R4w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, balajitk@ti.com, joelf@ti.com, Sekhar Nori <nsekhar@ti.com>, s.neumann@raumfeld.com, Gururaja Hebbar <gururaja.hebbar@ti.com>, Russ Dill <Russ.Dill@ti.com>, Daniel Mack <zonque@gmail.com>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Matt Porter <matt@ohporter.com>
List-Id: linux-omap@vger.kernel.org

On 11/07/2013 02:42 PM, Vaibhav Bedia wrote:
> Hi Nishanth :)
> On Thu, Nov 7, 2013 at 10:48 AM, Nishanth Menon <nm@ti.com> wrote:
>> On 11/07/2013 09:36 AM, Daniel Mack wrote:
>>> On 11/07/2013 04:18 PM, Nishanth Menon wrote:
>>>> Tested this on a vendor V3.12 tag based kernel:
>>>>
>>>> Test patch: http://pastebin.com/AmnktQ7B
>>>> test: echo -n "1">/sys/power/pm_print_times; rtcwake -d /dev/rtc0 -m
>>>> mem -s 5
>>>>
>>>>
>>>> with the current patch: http://pastebin.com/RujarRLV
>>>> suspend_late and resume_early: http://pastebin.com/RujarRLV
>>>
>>> These two are identical.
>>>
>>>> suspend_noirq and resume_noirq: http://pastebin.com/nKfbm7Mj
>>>
>>> And I can't see any difference between this one and the first one,
>>> except for slightly different timings. Am I missing anything?
>>
>> aah, that happens to be a little key :)
>> if you see the current patch, it happens around line 417,
>> with suspend_late, it moves deeper(or later) into suspend around 738
>> with noirq - it is as late as it can get - around line 823 just before
>> the last set of arch suspend calls are done.
>>
> 
> That's some nifty analysis overnight ;)
> 
> Yeah, the intention was to move the EDMA ops as late as possible.
> I am not sure if noirq thing takes care of the late i2c stuff to talk to the
> PMICs that happens on some OMAPs. Maybe the generic PM code
> handles that already but i am a bit rusty on the details right now so
> that would just mention that scenario to be considered.
> 

To trigger the fail, I created a custom Test case on TI vendor kernel
based on v3.12 tag:
On beagleBone-Black
test scenario (BBB):

    Boot from SD card
    ensure firmware is loaded (rev 0x182)
    run LTP fsstress [1] in background on EMMC
        mkdir -p /tmp/testing
        mke2fs /dev/mmcblk1p1
        mount /dev/mmcblk1p1 /tmp/testing
        fsstress -d /tmp/testing p 4 -n 1000 -l0 -v >/dev/null &
    run ping in the background (to add yet another interface)
    run memtester[2] (70% of free memory)
        memtester 343M >/dev/null &
        sleep 10 (to allow memtester to start up properly)
    start=`date`;i=0; while [ 1 ]; do rtcwake -d /dev/rtc0 -m mem -s
2; i=$((i + 1)); echo "$i: start =$start, now="`date`; sleep 2; done

Eventual hang log (using the regular suspend-resume): [3] - took close
to two days of testing to trigger this.

Moving to a suspend_late and resume_early such as in [4], it passed
the test for over 4 days now.

Daniel,
will be good if you could post [4] for comments if you think that is
the right thing to do and helps solve the issue you saw as  well.

[1]
https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/fs/fsstress

[2] http://pyropus.ca/software/memtester
[3] http://pastebin.pandaboard.org/index.php/view/18307529
[4]
https://git.ti.com/ti-linux-kernel/ti-linux-kernel/commit/f8f9a8c38644d27dc8671009209922531b072110
-- 
Regards,
Nishanth Menon
