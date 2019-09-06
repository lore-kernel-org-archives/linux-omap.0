From: Tomas Novotny <tomas@novotny.cz>
Subject: omap-mcbsp: TX Buffer Overflow
Date: Fri, 6 Sep 2019 16:51:09 +0200
Message-ID: <20190906165109.53c5a306@tomas.local.tbs-biometrics.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

Hi,

we have AM3703 based board similar to BeagleBoard. I'm hitting this error
after upgrade to latest LTS 4.19.71 (upgraded from 4.1):

omap-mcbsp 49022000.mcbsp: TX Buffer Overflow!

This appears during or after playing of short (~2s) ding-dong wav. That error
exists for longer time, because handling of tx buffer overflow irq was
introduced in 2016: 4e85e7776eba ("ASoC: omap-mcbsp: Enable TX/RX under and
overflow interrupts"). I've cherry-picked it to 4.1 and I see the error there also.
The sound seems clear and ok to me, but we are using low quality speaker.

There are two workarounds to get rid of the message:
1) Change 'dma_op_mode' sysfs attribute from 'element' to 'threshold'. I
found that just by coincidence when checking sysfs attributes.
2) Compile kernel with CONFIG_VIDEO_OMAP3=y. Found on Logic PD forum [1].

Does anybody have any idea what's going wrong? Or why these (somehow)
unrelated workarounds help?

Thanks,

Tomas

[1] https://support.logicpd.com/TDGForum/tabid/124/aft/2277/Default.aspx
