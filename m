From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: DMA or IRQ trouble while testing ALSA driver for omap
Date: Wed, 27 Jun 2007 16:26:52 +0530
Message-ID: <61445c750706270356j385b788am9b0309c915cda8a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Hi

I am using omap osk board and while testing the alsa driver in linux-omap1 tree,
I am getting the following errrors:

>ALSA sound/core/pcm_lib.c:1733: playback write error (DMA or IRQ trouble?)

After debugging it was revealed that the pointer function is not
working as expected
and it is returning wrong pos in hw buffer. I am referring file
omap-alsa.c. I have not modified the driver and other settings like
sample rate etc are set appropriately.

-pharaoh
