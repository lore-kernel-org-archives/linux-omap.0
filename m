From: Steve Poulsen <spoulsen@css-design.us>
Subject: Re: OMAP2430: networking errors
Date: Thu, 17 May 2007 13:20:28 -0500
Message-ID: <464C9CEC.5070806@css-design.us>
References: <57314e840705170701k79f76c5k79649f929bc63066@mail.gmail.com>	<3B6D69C3A9EBCA4BA5DA60D913027429010256C1@dlee13.ent.ti.com>
	<57314e840705170935u4791b98cs29504cf57523cbc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <57314e840705170935u4791b98cs29504cf57523cbc2@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Budhee,

If you are building your own kernel, I would just open smc91x.c and 
change the

#define SMC_DEBUG 0

to

#define SMC_DEBUG 4

I think that is enough to cause it to print out the packets it 
receives.   When you boot, you should get some printing when it tries to 
DHCP.  It is kind of a one-shot process since you can't mount a 
filesystem via NFS until the network is working.

I cannot help you with that specific board.  Richard may help more 
there.  I can just give you some ideas as to what I have done to track 
these down...the hard way.

Also, I would suggest checking your cables and hubs.  One thing I have 
noticed is that if you mess around changing MAC addresses, the ARP 
tables of various devices will end up wrong.   Unplugging and plugging 
your cable into a new slot of your hub (or power cycling your hub), 
should correct that.  The reason I bring this up is that you said U-boot 
sometimes will not reply to the ARP packet.   This is more disturbing 
than a simple case where a driver always fails.

Finally, I noticed my smc91x.h is patched for OMAP.  Around line 191 it 
looks like this:

#define    SMC_IRQ_FLAGS (( \
           machine_is_omap_h2() \
        || machine_is_omap_h3() \
        || machine_is_omap_h4() \
        || (machine_is_omap_innovator() && !cpu_is_omap1510()) \
    ) ? SA_TRIGGER_FALLING : SA_TRIGGER_RISING)

The patch added the machine_is_omap_h4() line.  This was the only thing 
patched in the driver that seemed relevant.  To be honest, I am not sure 
what is considered omap_h4 (h2, h3 show up in menuconfig and have a 
descriptions as to what they cover), but I would make sure yours looks 
like above, to confirm the proper patching.

I am using 2.6.16 patched for omap:

http://ftp.kernel.org/pub/linux/kernel/v2.6/
http://www.muru.com/linux/omap/patches/old/

Good luck!

Steve


Budhee Jamaich wrote:
> On 5/17/07, Woodruff, Richard <r-woodruff2@ti.com> wrote:
>>
>> > it's a development board. how do I know which ethernet chip is on it ?
>>
>> Ok.  Is it the TI-SDP2430 development board?
> yes. ethernet chip: SMC 91C96.
>
>>
>> If so, what images are you using?  Did you build them or use pre-built
>> ones.
> I built it. used TI's BSP. it is based on kernel 2.6.10.
> I am now cloning myself a copy of Tony's git tree.
> I will try to build it, maybe that will help.
>
> otherwise I guess I would have no choice but debug smc91x.c ?
>
>>
>> Why do you report your MAC address as  yy:yy:yy:yy:yy:yy.  Is that what
>> the driver said or did you remove it for some reason.
> oh, you will have to forgive me here.
> I usually remove personal data from posts to public mailing lists.
>
>>
>> If it works sometimes and not other times that is odd.  Are you using
>> the same MAC address on multiple board or something?
> hmm, the MAC address is the real hardware one. AFAIK it is
> unique for that specific board.
>
> Thank You !
> Budhee
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
