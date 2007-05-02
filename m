From: "Raghu TS" <raghuts@tivr.co.in>
Subject: Building Linux on OMAP-2430 SDP
Date: Wed, 2 May 2007 17:35:52 +0530
Message-ID: <KIEKKGBMLLBPKHIELIEEEEJCCBAA.raghuts@tivr.co.in>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello Linux Experts,

I am a newbie to embedded world specially Linux, though have a bit of
experience in DSP side programming. I have developed a multimedia codec on
OMAP-2430 SDP which will run on the DSP side. Now I need to make the codec
API call from ARM side. I have been trying to do this using Open source
Linux, but in vain. Please help me to do it.

What I understand is I have to build the Linux kernel for SDP, download the
same into  it and boot it. I referred to the document
"http://linux.omap.com/pub/documentation/OMAP_SDP.pdf" and built the Linux
Kernel image on a Fedora Linux-3 host PC. Now to downloand & boot this
kernel image, the document refers to
"http://linux.omap.com/pub/documentation/U-Boot%20for%20the%20OMAP16xx%20SDP
.pdf". It is here I am getting stuck as the last 'make' command in the
Section-7 of this document is not compiling and is citing a 'divsion by zero
error'. Also further in the document, in Section-9, it refers to IBoot Host
& IBoot Console software used to flash U-Boot on the OMAP1610 SDP which is
shipped with it. I don't have any such software from my OMAP-2430 SDP
shipment.

Am I doing the right things or missing a trick or two? Please guide me on
how to proceed.

Thanks & Regards,
Raghu TS
