From: "Azbell, Brandon" <b-azbell@ti.com>
Subject: RE: Using audio on OMAP OSK5912
Date: Fri, 17 Nov 2006 15:42:11 -0600
Message-ID: <AC9151450E120A459D078870E96B61CC08A8B10C@dlee06.ent.ti.com>
References: <A794DE2F81AEF94099397C9D7D5B651E015A578B@dlee08.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <A794DE2F81AEF94099397C9D7D5B651E015A578B@dlee08.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Kipisz, Steven" <s-kipisz2@ti.com>, Abot Botbot <dejanigma@hotmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Just to clarify, McBSP1 and McBSP3 are DSP Public Peripherals accessible
from the DSP and DSP DMA.  The ARM can access these two peripherals via
the MPUI interface into the DSP subsystem domain.

McBSP2 is a shared peripheral which can be accessed by DSP, ARM and
System DMA.

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
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Kipisz, Steven
Sent: Friday, November 17, 2006 12:25 PM
To: Abot Botbot; linux-omap-open-source@linux.omap.com
Subject: RE: Using audio on OMAP OSK5912

I don't have my 5912 TRM handy, but if I remember correctly, McBSP1 and
McBSP3 are DSP Public peripherals so you can access both from ARM or
DSP.  McBSP2 is ARM only.

Steve K.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Abot
Botbot
Sent: Friday, November 17, 2006 12:17 PM
To: linux-omap-open-source@linux.omap.com
Subject: RE: Using audio on OMAP OSK5912

Folks,

  I thought the only way to interface the audio codec on the 5912 was=20
through the GPP side, that the DSP core had no connectivity to this
device.=20
This required using either DSP/BIOS a-la the RF6 app, or using DSP
Gateway,=20
both of which transfer the samples over a shared memory interface to the

DSP. Is this correct?

Thanks,
Andy


>From: "Ishigami, Tatsuya" <ishigami@ti.com>
>To: "Carlos, John J DA CIV USA ATC" <john.carlos@atc.army.mil>
>CC: Linux-Omap-Open-Source <linux-omap-open-source@linux.omap.com>
>Subject: RE: Using audio on OMAP OSK5912
>Date: Fri, 17 Nov 2006 11:50:12 -0600
>
>Hi John,
>
>  Ideally, the OMAP5912 would perform better
>(faster and consumes less power), if the DSP
>both read and process the data.
>
>  This is because (a) the McBSP1 is the DSP's
>peripheral, and (b) the DSP is the processor
>specially designed for signal processing :-)
>
> > Also that is the best way to make sure
> > you are sampling at a set frequency?
>
>  A quick way would be
>
>  1) Record sound with the OSK5912 to a file.
>  2) Transfer the file to PC
>  3) Convert this raw data into WAV format
>     (with the sampling rate & bit-resolution
>      info you set)
>  3) Play the WAV file to hear if it sounds same.
>
>  Regards,
>  Ishigami
>
>-----Original Message-----
>From: Carlos, John J DA CIV USA ATC [mailto:john.carlos@atc.army.mil]
>Sent: Thursday, November 16, 2006 10:48 AM
>To: Linux-Omap-Open-Source
>Subject: Using audio on OMAP OSK5912
>
>Hello All,
>
>   I am seeking advice.  I have seen some emails about using the audio
>chip
>on OSK.  My question: what would be better 1.  Have arm read data from
>aic23
>and DSP process or 2.  have DSp read data and arm process.  I would
>think
>the first would be more desirable.  Also that is the best way to make
>sure
>you are sampling at a set frequency?
>
>Thanks,
>John
>
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source

_________________________________________________________________
Stay up-to-date with your friends through the Windows Live Spaces
friends=20
list.=20
http://clk.atdmt.com/MSN/go/msnnkwsp0070000001msn/direct/01/?href=3Dhttp:=
/
/spaces.live.com/spacesapi.aspx?wx_action=3Dcreate&wx_url=3D/friends.aspx=
&mk

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
