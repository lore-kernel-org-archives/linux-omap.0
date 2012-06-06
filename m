From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Please help! AM35xx mm/slab.c BUG
Date: Wed, 6 Jun 2012 00:08:54 -0700 (PDT)
Message-ID: <1338966534.67242.YahooMailNeo@web125206.mail.ne1.yahoo.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com> <20120605070853.GE12766@atomide.com> <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com> <1338963298.87083.YahooMailNeo@web125204.mail.ne1.yahoo.com> <CAMQu2gw2bGNwot_xVPdAsYjZChzzNib2USg8Ci+W5aLbenPnqA@mail.gmail.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm32-vm5.bullet.mail.ne1.yahoo.com ([98.138.229.53]:30228 "HELO
	nm32-vm5.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751225Ab2FFHOG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Jun 2012 03:14:06 -0400
In-Reply-To: <CAMQu2gw2bGNwot_xVPdAsYjZChzzNib2USg8Ci+W5aLbenPnqA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Santosh,

Thanks for the comments!=A0 If you do not think the GPMC can be a facto=
r here, that's great news.=A0 I'd certainly love to take something off =
the list.


Unfortunately, we've run the "memtester 200M" (we only have 256MB) in c=
onstant cycles for weekends at a time, and have not had it crash.=A0 We=
 did this back when we thought perhaps our RAM timings were wrong since=
 the NANYA chip was not one mentioned in the source anywhere.=A0 If we =
were having memory errors, I would suspect that would have caught them =
correct?=A0 Should we run that with a larger number than 200?=A0 We did=
n't want to dig into our operating system's space too much.


Thanks again!



----- Original Message -----
=46rom: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
To: CF Adad <cfadad@rocketmail.com>
Cc: Tony Lindgren <tony@atomide.com>; "linux-omap@vger.kernel.org" <lin=
ux-omap@vger.kernel.org>
Sent: Wednesday, June 6, 2012 2:36 AM
Subject: Re: Please help! AM35xx mm/slab.c BUG

On Wed, Jun 6, 2012 at 11:44 AM, CF Adad <cfadad@rocketmail.com> wrote:
> All,
>
>
> We've learned a few more things:
>
> 1.) We have found a way to get it to happen pretty consistently.=A0 W=
e simply run iperf in a loop using the EMAC port to some other device.
>
>
> 2.) The crash ONLY happens on our custom board, not on the Twister de=
v kit.=A0 This is true despite the fact that I ported our latest linux-=
omap 3.4-rc6 over there.=A0 We're still running Technexion's default x-=
loader and u-boot to handle proper configs on that board. So, that's a =
substantial bit of code that is different between our boxes.=A0 The ker=
nel is altered only in that the few pinmux changes I left in Linux have=
 been removed to avoid configuration differences between the two boards=
=2E
>
>
> This suggests that either:
> A) We have a hardware problem on our board.=A0 Seems unlikely.=A0 Can=
 anyone think of anything hardware related that would manifest itself w=
ith these sorts of errors?
>
>
> B) We have a issue in our bootloader code somehwere.=A0 I hesitated t=
o overwrite the bootloaders for this test on the Twister baseboard just=
 because I did not want to have to mess with getting the pinmux's and t=
he like put back and such.
>
> Presuming something in those bootloaders is our problem, I wonder wha=
t EMAC-related stuff there really is.=A0 For a long time we ran with ou=
r bootloaders NOT initializing either of the Eths.=A0 This was Technexi=
on's default.=A0 They left that work to Linux.=A0 We've recently done w=
ork to enable them in u-boot, but we were crashing like this long befor=
e that.=A0 Once in Linux, we're just using the standard drivers and cal=
ls from within the board file to SMSC911x and the Davinci EMAC drivers.=
=A0 I am using the patches that allow the e-fused MAC to be pulled from=
 the AM35xx for the EMAC, but I can't see how that would cause this.
>
> Assuming the EMAC is perhaps an innocent bystander that happens just =
to cause this, the place I would have to suspect the most in our bootlo=
aders would be the GPMC settings.=A0 We've done a good bit of tweaking =
in there since we switched chips.=A0 *Could a GPMC timing issue account=
 for these types of errors???*=A0 The reason I bring it up is that the =
GPMC has been one of those things that we've really struggled to unders=
tand.=A0 What should the timings *really* be?=A0 We've done the best we=
 can to try to guess our way through it.=A0 BUT, we could certainly be =
very wrong.=A0 If a GPMC setting could cause these types of bugs, pleas=
e let me know.=A0 I'll be happy to post more info on how we're setting =
that up now.=A0 In case not, I'll save the electrons and not spam it he=
re.
>
>
I don't know the AMXX architecture that well but looking at the
crash-log, am not sure GPMC should play in role here.
What I think is, it is mostly memory corruption and can be caused by
many reasons as Tony outlined.

To ensure that, your memory is in good state, can you run memtester
for long duration and see that you
are not getting any memory failures. Try to give the maximum memory
size as a an input to memtester.

You can download one from [1]

Regards
Santosh
[1] http://pyropus.ca/software/memtester/

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
