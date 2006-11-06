From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: I2C zero length transfers and SMBUS_QUICK,
	was: Pending October patches
Date: Mon, 06 Nov 2006 11:36:08 +0100
Message-ID: <85d580lv53.fsf@orfeo.duckcorp.org>
References: <20061105194915.12776.qmail@web37903.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061105194915.12776.qmail@web37903.mail.mud.yahoo.com> (Komal
	Shah's message of "Sun, 5 Nov 2006 11:49:15 -0800 (PST)")
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hi,

Komal Shah <komal_shah802003@yahoo.com> writes:

> --- Dirk Behme <dirk.behme@googlemail.com> wrote:
>
>
>> >>Komal, what do you think here?
>> >>
>> >>Anybody aware of someone working on a better solution? Any 
>> >>link to the LKML discussion about this?
>> >>
>> > Few links:
>> ...
>> >
>>
> http://linux.omap.com/pipermail/davinci-linux-open-source/2006-October/001332.html
>> 
>> Sounds to me a clean fix (new I2C stack?) will need some 
>> decades, if it comes at all. So, how to go one here?
>> 
>> Our hack to make things work on OMAP will not be accepted 
>> upstream. But staying with broken OMAP features only because 
>> (available) hack isn't acceptable in mainline doesn't sound 
>> like an option as well.
>> 
>> I personally vote for working OMAP ;)
>> 
>
> Yes, we need working OMAPs and I don't know if it already broke n770
> too. Let's see what Tony thinks about maintaining this fix in OMAP tree.
>
hmm... well... while taking care of the n770 is nice, I'm not sure that
you should take it into account. 

Brief explanation : 
the current kernel is broken on the n770. It won't even build.

Long explanation :
There are some obvious breakages that are not fixed. For instance, look
at the omap-hw patch I sent. I have some other patches for the build but
the kernel is oopsing later in the boot stage when udev plays with the
uevents in the spi layer... And there are probably more breakages :(


Regards,
Arnaud
