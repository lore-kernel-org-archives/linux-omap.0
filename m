From: "Ishigami, Tatsuya" <ishigami@ti.com>
Subject: RE: Using audio on OMAP OSK5912
Date: Fri, 17 Nov 2006 11:50:12 -0600
Message-ID: <772F5D89C5E0734B8A86D85DFC6A202405226000@dlee03.ent.ti.com>
References: <22CECCE071A8DC4CAB2412DC44CBEDF107A5A80C@apgrb1atc-0058e.atc.army.mil>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <22CECCE071A8DC4CAB2412DC44CBEDF107A5A80C@apgrb1atc-0058e.atc.army.mil>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Carlos, John J DA CIV USA ATC" <john.carlos@atc.army.mil>
Cc: Linux-Omap-Open-Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi John,

 Ideally, the OMAP5912 would perform better
(faster and consumes less power), if the DSP
both read and process the data.

 This is because (a) the McBSP1 is the DSP's
peripheral, and (b) the DSP is the processor
specially designed for signal processing :-)

> Also that is the best way to make sure
> you are sampling at a set frequency?=20

 A quick way would be=20

 1) Record sound with the OSK5912 to a file.
 2) Transfer the file to PC
 3) Convert this raw data into WAV format
    (with the sampling rate & bit-resolution
     info you set)
 3) Play the WAV file to hear if it sounds same.

 Regards,
 Ishigami

-----Original Message-----
From: Carlos, John J DA CIV USA ATC [mailto:john.carlos@atc.army.mil]=20
Sent: Thursday, November 16, 2006 10:48 AM
To: Linux-Omap-Open-Source
Subject: Using audio on OMAP OSK5912

Hello All,

  I am seeking advice.  I have seen some emails about using the audio
chip
on OSK.  My question: what would be better 1.  Have arm read data from
aic23
and DSP process or 2.  have DSp read data and arm process.  I would
think
the first would be more desirable.  Also that is the best way to make
sure
you are sampling at a set frequency?

Thanks,
John
