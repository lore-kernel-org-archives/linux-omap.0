From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv3 2/9] ARM: OMAP2+: AM33XX: control: Add some control
 module registers and APIs
Date: Tue, 13 Aug 2013 14:40:35 -0400
Message-ID: <520A7DA3.5010907@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-3-git-send-email-d-gerlach@ti.com>
 <5203A0BC.8060205@ti.com> <5203C457.80301@ti.com>
 <20130809051146.GB7656@atomide.com> <52055733.70808@ti.com>
 <87y586pvkq.fsf@kernel.org> <5209565C.7090508@ti.com>
 <87d2phpsu1.fsf@kernel.org> <520A4BE7.7090603@ti.com>
 <87wqnplg1n.fsf@kernel.org> <520A785C.3000304@ti.com>
 <CA+Bv8Xbg9v4zRy-EJPsxwCdwpSy50V8SjwQfmAvVxiCR=6mYBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CA+Bv8Xbg9v4zRy-EJPsxwCdwpSy50V8SjwQfmAvVxiCR=6mYBw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russ Dill <russ.dill@gmail.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 13 August 2013 02:30 PM, Russ Dill wrote:
>>>> ARM world is also moving towards that by standardizing some of these
>>>> through (read PSCI) and thats the way to go in general.
>>>
>>> Agreed, but I'm not sure (yet) about enforcing PSCI on legacy platforms
>>> that don't support it natively.  Are you saying that the AM33xx firmware
>>> should be converted to be PSCI compliant?  Admittedly, I haven't read
>>> the PSCI spec closely, but I'm wondering if the current role splitting
>>> between MPU and M3 fits well with PSCI.
>>>
>> I didn't mean for the AM3XXX specifically because its current job is rather
>> very limited. i.e suspend. My concern is that IPC is not viewed as
>> an option for power management controllers like M3 which can abstract
>> all the hardware gory details and export a simpled interface for OS
>> in form of PSCI/ACPI.
> 
> The IPC between the M3 and the A8 on the am335x is just a pair of
> notification mechanisms (one from the A8, mailbox, and one from the
> M3, sev) and a set of 8 32 bit registers. The 8 32 bit registers are
> just a scratchpad and have no access rules or functionality beyond
> being a scratchpad. How complicated do we want to make this?
> 
Exactly what I mean as well.

Regards,
Santosh
