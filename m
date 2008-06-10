From: "Suresh Rajashekara" <srajashekara@vocera.com>
Subject: RE: omap osk audio
Date: Tue, 10 Jun 2008 15:13:26 -0700
Message-ID: <E0C15250B56CB5468389360E1E6D655D0EB621@Nebula.vocera.local>
References: <a1d91fa0806100733o71e5f1dx5bed802e65275ccc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-newbie-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <a1d91fa0806100733o71e5f1dx5bed802e65275ccc@mail.gmail.com>
Sender: linux-newbie-owner@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>, omap <linux-omap@vger.kernel.org>, linux-newbie@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

I see that the drivers getting loaded are the ALSA drivers. You are
trying to create the nodes which usually the OSS applications use to
talk to the OSS audio drivers. Unless you have the OSS emulation enabled
in the kernel/user space, you can't use the audio device through these
nodes. Use some ALSA application. Refer to ALSA website for creating
your own sample application. Also you will need to create the device
nodes for ALSA and also place the config files accordingly.

Please someone correct me if I am wrong.

Regards,
Suresh 

-----Original Message-----
From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of mohammed shareef
Sent: Tuesday, June 10, 2008 7:34 AM
To: omap; linux-newbie@vger.kernel.org
Subject: omap osk audio

Dear all,

I am working on omap osk. i want to enable audio on it. But am not able
to do that. The kernel boot log says it has initialized audio device.
but i am not able to configure the audio setting nor run some recording
code. the system hangs and i have to restart.

the kernel boot code says:

TLV320AIC23 I2C version 1.8 (10-Feb-2006) audio support initialized ALSA
device list:
 #0: OSK AIC23

i have created nodes:

# mknod /dev/mixer c 14 0
# mknod /dev/dsp c 14 3

thanx,
Shareef
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org More majordomo info
at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-newbie" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.linux-learn.org/faqs
