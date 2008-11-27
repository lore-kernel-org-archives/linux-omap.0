From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCHv2 0/1] OMAP_TWL4030 SoC Audio driver.
Date: Thu, 27 Nov 2008 20:50:56 +0800
Message-ID: <1227790257-14221-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, broonie@sirena.org.uk
List-Id: linux-omap@vger.kernel.org

Changes from v1:

1, change the name from omap-general to omap_twl4030.

2, proune off board related defines.

3, add a extended interface omap_twl4030_specific_init() to support some board
specific features.


If some board specific features are added into a board, for example, omap3evm
board. we can create a new file omap3evm.c and define a funciton
omap_twl4030_specific_init() in it, and select SND_OMAP_TWL4030_SPECIFIC in
config SND_OMAP_SOC_OMAP3EVM.
