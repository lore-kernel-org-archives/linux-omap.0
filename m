From: ruchir.gulati@tcs.com
Subject: RE: Linux audio driver OMAP5912
Date: Thu, 4 May 2006 17:59:05 +0530
Message-ID: <OF7625A7D7.954C6AEA-ON65257164.0043E1C5-65257164.004485A8@tcs.com>
References: <520AB2AD990DC04082102F77CA172638033F0DD1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <520AB2AD990DC04082102F77CA172638033F0DD1@dlee03.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Menon, Nishanth" <x0nishan@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Is it so that the OSS driver on the OMAP5912will not work in the 
full-dulpex mode at all? I think the problem I am facing presently is of 
buffer underrun while audio playback, and hope to resolve it by trying 
different fragment sizes. I really hope this works! Any more help/tips on 
this topic??
Please let me know if switching to ALSA would be absolutely necessary for 
supporting full-duplex sort of functioning on the OMAP5912

Thanks & Regards,
Ruchir Gulati




"Menon, Nishanth" <x0nishan@ti.com> 
04/26/2006 08:08 PM

To
<ruchir.gulati@tcs.com>, <linux-omap-open-source@linux.omap.com>
cc

Subject
RE: Linux audio driver OMAP5912






Hi Ruchir,
> Sometimes it gives the error message like Omap_audio: DMA IRQ received 
for non-existing buffer. Ultimately the board hangs and a reboot needs to 
be done. 
This points at some sort of buffer handling issues on the audio layer. The 
OSS driver is kind of deprecated now-a-days. Have you tried alsa driver 
yet? This should be present in the latest omap-linux git tree.
 
> Can someone please tell me where the problem is? If the problem is with 
device fragment size, then what is the correct procedure for setting the 
same, and to what value should it be set? If somone working on the OMAP 
5912 has come across similar problems, and fixed them, then please throw 
some light on the solution for me also! 
Check out oss.pdf again for DSP_SETFRAGMENTS ioctl for adjusting the 
kernel buffer parameters.
 
Regards,
Nishanth Menon
ForwardSourceID:NT0000473A 
=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you
