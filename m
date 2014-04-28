From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 1/9] ASoC: omap: rx51: Use static const char
	* const arrays
Date: Mon, 28 Apr 2014 16:07:19 +0200
Message-ID: <1398694047-28596-2-git-send-email-sre@kernel.org>
References: <1398694047-28596-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1398694047-28596-1-git-send-email-sre@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sre@ring0.de>, Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

Mark the array and the string const by using "static const char * const
foo[]" instead of "static const char* foo[]".

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 sound/soc/omap/rx51.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index add0047..1a3f05c 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -258,9 +258,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"b Mic Bias", NULL, "HS Mic"}
 };
 
-static const char *spk_function[] = {"Off", "On"};
-static const char *input_function[] = {"ADC", "Digital Mic"};
-static const char *jack_function[] = {"Off", "TV-OUT", "Headphone", "Headset"};
+static const char * const spk_function[] = {"Off", "On"};
+static const char * const input_function[] = {"ADC", "Digital Mic"};
+static const char * const jack_function[] = {
+	"Off", "TV-OUT", "Headphone", "Headset"
+};
 
 static const struct soc_enum rx51_enum[] = {
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(spk_function), spk_function),
-- 
1.9.2
