From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Disable DSPGW fails
Date: Wed, 04 Oct 2006 10:47:38 +0200
Message-ID: <4523752A.8020601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

while debugging the OSK issue, I tried to disable DSPGW 
completely (CONFIG_OMAP_DSP is not set). On most recent git 
this fails with

arch/arm/plat-omap/built-in.o: In function `omap_mcbsp_free':
mcbsp.c:(.text+0x44b8): undefined reference to 
`omap_dsp_release_mem'
arch/arm/plat-omap/built-in.o: In function `omap_mcbsp_request':
mcbsp.c:(.text+0x45cc): undefined reference to 
`omap_dsp_request_mem'

Anybody with an idea how to fix this?

Best regards

Dirk
