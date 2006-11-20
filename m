From: "Azbell, Brandon" <b-azbell@ti.com>
Subject: RE: Using audio on OMAP OSK5912
Date: Mon, 20 Nov 2006 14:31:22 -0600
Message-ID: <9E8AB4F8CD83E542A3EF3F7DD3E7C55F09F969@dlee11.ent.ti.com>
References: <BAY102-F38DAFF349EAC6A1758126DA9ED0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <BAY102-F38DAFF349EAC6A1758126DA9ED0@phx.gbl>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Abot Botbot <dejanigma@hotmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Andy,

	I presume you are using the following user's guide for the
OSK5912 that provides a pictorial view of RF6 running on the OMAP5912.
The diagram on Page 4 of this document shows a bubble entitled "Data
Processing Thread" running on the ARM.  Is this the hack that you are
referring to?

http://omap.spectrumdigital.com/osk5912/files/osk5912_usersguide.pdf

	If yes, this in my opinion represents a potential "thing" that
can be done with audio data AFTER the DSP has processed it with any
number of algorithms.  This "thing" could be packetizing this into an IP
network packet and send it somewhere, or it could be performing
something like Voice Recognition algorithms, etc.  This really is to
depict that RF6 has built-in facilities to demonstrate ARM+DSP
communication via DSP-Link.  It is my understanding the package comes
with basically a loop-back in the ARM side "Data Processing Thread".

	In this example, the DSP does actually capture data directly and
sends data directly to the AIC23.


Regards,=20

Brandon Azbell=20
Texas Instruments=20
Senior, Group Technical Staff=20
System Applications=20
b-azbell@ti.com  email=20
847.517.4536      voice=20
847.517.4576      fax=20
630.561.9593      mobile=20


-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Abot
Botbot
Sent: Monday, November 20, 2006 11:51 AM
To: linux-omap-open-source@linux.omap.com
Subject: RE: Using audio on OMAP OSK5912

Azbell,

  Well this begs the question. Why am I trying to hack the RF6 to do my=20
audio processing? Is there a document or example of how to read and
write=20
samples to and from the DSP without using the ARM? Another happy outcome

would be doing this while Linux was still alive on the system. I would
be=20
very happy to see that.

Thanks,
Andy


>From: "Azbell, Brandon" <b-azbell@ti.com>
>To: "Kipisz, Steven" <s-kipisz2@ti.com>, "Abot Botbot"=20
><dejanigma@hotmail.com>,        <linux-omap-open-source@linux.omap.com>
>Subject: RE: Using audio on OMAP OSK5912
>Date: Fri, 17 Nov 2006 15:42:11 -0600
>
>Just to clarify, McBSP1 and McBSP3 are DSP Public Peripherals
accessible
>from the DSP and DSP DMA.  The ARM can access these two peripherals via
>the MPUI interface into the DSP subsystem domain.
>
>McBSP2 is a shared peripheral which can be accessed by DSP, ARM and
>System DMA.
>
>Regards,
>
>Brandon Azbell
>Texas Instruments
>Senior, Group Technical Staff
>System Applications
>b-azbell@ti.com  email
>847.517.4536      voice
>847.517.4576      fax
>630.561.9593      mobile
>
>
>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com
>[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
>Kipisz, Steven
>Sent: Friday, November 17, 2006 12:25 PM
>To: Abot Botbot; linux-omap-open-source@linux.omap.com
>Subject: RE: Using audio on OMAP OSK5912
>
>I don't have my 5912 TRM handy, but if I remember correctly, McBSP1 and
>McBSP3 are DSP Public peripherals so you can access both from ARM or
>DSP.  McBSP2 is ARM only.
>
>Steve K.
>
>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com
>[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Abot
>Botbot
>Sent: Friday, November 17, 2006 12:17 PM
>To: linux-omap-open-source@linux.omap.com
>Subject: RE: Using audio on OMAP OSK5912
>
>Folks,
>
>   I thought the only way to interface the audio codec on the 5912 was
>through the GPP side, that the DSP core had no connectivity to this
>device.
>This required using either DSP/BIOS a-la the RF6 app, or using DSP
>Gateway,
>both of which transfer the samples over a shared memory interface to
the
>
>DSP. Is this correct?
>
>Thanks,
>Andy
>
>
> >From: "Ishigami, Tatsuya" <ishigami@ti.com>
> >To: "Carlos, John J DA CIV USA ATC" <john.carlos@atc.army.mil>
> >CC: Linux-Omap-Open-Source <linux-omap-open-source@linux.omap.com>
> >Subject: RE: Using audio on OMAP OSK5912
> >Date: Fri, 17 Nov 2006 11:50:12 -0600
> >
> >Hi John,
> >
> >  Ideally, the OMAP5912 would perform better
> >(faster and consumes less power), if the DSP
> >both read and process the data.
> >
> >  This is because (a) the McBSP1 is the DSP's
> >peripheral, and (b) the DSP is the processor
> >specially designed for signal processing :-)
> >
> > > Also that is the best way to make sure
> > > you are sampling at a set frequency?
> >
> >  A quick way would be
> >
> >  1) Record sound with the OSK5912 to a file.
> >  2) Transfer the file to PC
> >  3) Convert this raw data into WAV format
> >     (with the sampling rate & bit-resolution
> >      info you set)
> >  3) Play the WAV file to hear if it sounds same.
> >
> >  Regards,
> >  Ishigami
> >
> >-----Original Message-----
> >From: Carlos, John J DA CIV USA ATC [mailto:john.carlos@atc.army.mil]
> >Sent: Thursday, November 16, 2006 10:48 AM
> >To: Linux-Omap-Open-Source
> >Subject: Using audio on OMAP OSK5912
> >
> >Hello All,
> >
> >   I am seeking advice.  I have seen some emails about using the
audio
> >chip
> >on OSK.  My question: what would be better 1.  Have arm read data
from
> >aic23
> >and DSP process or 2.  have DSp read data and arm process.  I would
> >think
> >the first would be more desirable.  Also that is the best way to make
> >sure
> >you are sampling at a set frequency?
> >
> >Thanks,
> >John
> >
> >_______________________________________________
> >Linux-omap-open-source mailing list
> >Linux-omap-open-source@linux.omap.com
> >http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>_________________________________________________________________
>Stay up-to-date with your friends through the Windows Live Spaces
>friends
>list.
>http://clk.atdmt.com/MSN/go/msnnkwsp0070000001msn/direct/01/?href=3Dhttp=
:
/
>/spaces.live.com/spacesapi.aspx?wx_action=3Dcreate&wx_url=3D/friends.asp=
x&m
k
>
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source

_________________________________________________________________
Get free, personalized commercial-free online radio with MSN Radio
powered=20
by Pandora http://radio.msn.com/?icid=3DT002MSN03A07001

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
