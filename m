From: "Prakash Narayanan M" <mnarayan@cedt.iisc.ernet.in>
Subject: RE: Linux-omap-open-source Digest, Vol 23, Issue 18
Date: Fri, 10 Mar 2006 09:50:23 +0530
Message-ID: <9343BE359FA4224CA72A94D8CC362C9C09364B@edpc500.cedt.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dear Mika

First of all thanks for the reply.

I am using kernel 2.4.19, with rmk7 patches for omap/kernel, in which, I
think Alsa is not available.  As you guessed correctly I am using OSS.
#cat audio.raw > /dev/dsp also gives me just noise.  Also it looks the
moment I open the dsp device it starts giving noise (In the C program I
mentioned in earlier mail).  I am not sure how to proceed.  Suggestions
are welcome

Regards
Prakash



-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
linux-omap-open-source-request@linux.omap.com
Sent: Thursday, March 09, 2006 11:30 PM
To: linux-omap-open-source@linux.omap.com
Subject: Linux-omap-open-source Digest, Vol 23, Issue 18

Send Linux-omap-open-source mailing list submissions to
	linux-omap-open-source@linux.omap.com

To subscribe or unsubscribe via the World Wide Web, visit
	http://linux.omap.com/mailman/listinfo/linux-omap-open-source
or, via email, send a message with subject or body 'help' to
	linux-omap-open-source-request@linux.omap.com

You can reach the person managing the list at
	linux-omap-open-source-owner@linux.omap.com

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Linux-omap-open-source digest..."


Today's Topics:

   1. Re: Sound on OMAP1510 Innovator (lamikr)


----------------------------------------------------------------------

Message: 1
Date: Thu, 09 Mar 2006 19:08:26 +0200
From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: Sound on OMAP1510 Innovator
To: Prakash Narayanan M <mnarayan@cedt.iisc.ernet.in>
Cc: linux-omap-open-source@linux.omap.com
Message-ID: <4410610A.5060206@cc.jyu.fi>
Content-Type: text/plain; charset=3Dus-ascii

Hi

Assuming that you are using /dev/dsp you are using OSS version from the
aic23 driver, am I correct?
Have you tested with the alsa version? In addition is normal music play
working ok for you?
("cat song.wav > /dev/dsp" with the oss driver and "aplayer song.wav"
with the alsa driver)

Mika

>I am trying to use the Sound device on Innovator OMAP1510.
>
>I am testing with a c code to acquire for sometime (3s) through the mic
>and replay it through the speaker.
> =20
>



------------------------------

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source


End of Linux-omap-open-source Digest, Vol 23, Issue 18
******************************************************
