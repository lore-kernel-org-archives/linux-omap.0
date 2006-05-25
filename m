From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: OPIE on Innovator 1510
Date: Thu, 25 May 2006 14:52:53 +0300
Message-ID: <44759A95.9040902@cc.jyu.fi>
References: <fd1e34b0605240419k2a874d47w97d4a908d3e0e9b7@mail.gmail.com>	<fb249edb0605240534h135b1a36q3600950ee61f1d5b@mail.gmail.com>
	<fd1e34b0605250322t3b6cd133hc68cdfed3fae0831@mail.gmail.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <fd1e34b0605250322t3b6cd133hc68cdfed3fae0831@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: James Selvam <james.iisc@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

The problem is caused because unlike generic omap1510, the h6300 uses
tsc2101 chip for the sound and touschreen.
So if you want to use that image, you need propably build and install a
new omap1510 kernel for that image.

Then you need to make sure that /etc/modules contains the drivers you
need to use.
In addition for this, you need propably change also the tslib
configuration to be generic omap1510 specific.
See /etc/profile.d/tslib.sh...

Mika
James Selvam wrote:

> Hi All,
>
> As specified in my earlier mail, I have downloaded an opie built
> rootfs. But
> the OPIE will not go beyond the initial screen. It asks me to tap to
> start
> but does not. Also if I ran the OPIE applications (like calculator or
> datebook) from debug console it puts up the appln window but does not
> take
> the input from touch screen.
>
> I then independantly compiled applications like ts_calibrate and ran
> it. It
> runs; and gives the right coordinates; showing that the touchscreen
> interface is all right.
>
> Now the only difference I can see is that these applications
> (ts_calibrate)
> were statically built (without dynamical linking) whereas OPIE may
> not. But
> when I am loading the applications (like calculator) certain messages are
> thrown out which indicate dynamic linking (the libapplets.so being loaded
> etc).
>
> Is there any configuration that I am missing?
>
> Regards,
> James.
>
> PS :  The udev indeed has problems due to which certain devices are not
> created. All devices have been manually created and the corresponding
> /dev/input/input0/event0 is added & working.
>
> On 5/24/06, andrzej zaborowski <balrog@zabor.org> wrote:
>
>>
>> Hi,
>>
>> On 24/05/06, James Selvam <james.iisc@gmail.com> wrote:
>> > Hi All,
>> >
>> > Im trying to use OPIE on my OMAP 1510 Innovator board. I have used the
>> root
>> > file system image available at familiar.handhelds.org (
>> > opie-image-v0.8.4-rc1-h6300.rootfs.tar.bz2).
>> >
>> > I have enabled the Touchscreen as an input device and configured the
>> OMAP
>> > Innovator touchscreen. This has indeed been enabled as seen from the
>> > following messages at bootup:
>> >
>> > ts: Compaq touchscreen protocol output
>> > input: omap_ts as /class/input/input0
>> > OMAP touchscreen driver initialized
>> >
>> > The innovator, however, comes to the startup screen and stops there
>> waiting
>> > to be tapped. It does not take the tapping.
>> >
>> > The debug console shows that the udev is unable to create the
>> > /dev/input/input0/event0 device.
>> >
>> > There seems to be a missing link between the drivers and the
>> application. If
>> > anybody has faced similar issues plz let me know.
>>
>> Yes, it seems there is something wrong with udev in recent familiar
>> images, so we just disable udev when using this image and recreate the
>> /dev nodes manually in one of the init scripts before X in
>> /etc/init.d, e.g.
>>   mkdir -p /dev/input
>>   mknod /dev/input/event0 c 13 64
>>   mknod /dev/input/event1 c 13 65
>> etc, or you can just make sure that nothing overwrites /dev. If you
>> also experience problems with the calibration, the easiest hack is to
>> calibrate the touchscreen without OPIE (e.g in GPE) and copy
>> /etc/pointercal over.
>>
>> >
>> > Thanx,
>> > James.
>> > _______________________________________________
>> > Linux-omap-open-source mailing list
>> > Linux-omap-open-source@linux.omap.com
>> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>> >
>>
>> Greetings,
>> Andrew
>> -- 
>> balrog 2oo6
>>
>> Dear Outlook users: Please remove me from your address books
>> http://www.newsforge.com/article.pl?sid=03/08/21/143258
>>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
