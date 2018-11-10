From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH v3 0/8] ASoC: omap-mcbsp: Cleanup and split
 core/sidetone support
Date: Sat, 10 Nov 2018 17:59:57 +0200
Message-ID: <c2e86562-49f0-9600-3df7-87de40caec06@bitmer.com>
References: <20181108073000.21114-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181108073000.21114-1-peter.ujfalusi@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/8/18 9:29 AM, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v2:
> - Split the dma_data addr and maxburst cleanup patches
> - Added Jarkko's Acked-by tot he series.
> 
Here's my promised testing too. I used a setup below to test sidetone
functionality. Assuming both playback and recording path are already set.

amixer -D hw:0 set 'McBSP2 Sidetone' on
amixer -D hw:0 set 'McBSP2 Sidetone Channel 0' 100%
amixer -D hw:0 set 'McBSP2 Sidetone Channel 1' 100%
echo 32767 >/sys/devices/platform/68000000.ocp/49022000.mcbsp/st_taps
echo threshold
>/sys/devices/platform/68000000.ocp/49022000.mcbsp/dma_op_mode
arecord -f dat >/dev/null |aplay -f dat /dev/zero

^^
arecord dumps into /dev/null and aplay plays from /dev/zero so only path
from input to output is the sidetone path.

Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
