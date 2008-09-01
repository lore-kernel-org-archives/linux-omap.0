From: sakoman@gmail.com
Subject: [PATCH 0/4] ARM: OMAP2: Add support for Gumstix Overo
Date: Mon,  1 Sep 2008 14:57:55 -0700
Message-ID: <1220306279-27977-1-git-send-email-sakoman@gmail.com>
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
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org


This patch series adds support for the Gumstix Overo board.  Since it includes an ASoC driver I am copying both linux-omap and alsa-devel

The first patch adds the basic board files, the second adds an ASoC driver for the TWL4030 codec, the third an ASoC machine driver for the Overo, and the final patch is the Overo defconfig
