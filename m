From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC] ASoC: simple-card: Update clocks binding for simple-card DAI subnodes
Date: Fri, 11 Sep 2015 16:18:02 +0300
Message-ID: <1441977482-29215-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Xiubo.Lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The updated binding provides a way to set clock-ID and direction
parameters for DAI drivers set_sysclk() call back.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
I proposed something similar about a year ago, but Mark rejected that
at the time. This RFC is to start that discussion again. This time
before I do any code changes.

Best regards,
Jyri

 Documentation/devicetree/bindings/sound/simple-card.txt | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index cf3979e..d10bf2d 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -76,6 +76,7 @@ Optional CPU/CODEC subnodes properties:
 - dai-tdm-slot-num			: Please refer to tdm-slot.txt.
 - dai-tdm-slot-width			: Please refer to tdm-slot.txt.
 - clocks / system-clock-frequency	: specify subnode's clock if needed.
+
 					  it can be specified via "clocks" if system has
 					  clock node (= common clock), or "system-clock-frequency"
 					  (if system doens't support common clock)
@@ -83,7 +84,21 @@ Optional CPU/CODEC subnodes properties:
 					  enabled with clk_prepare_enable()
 					  in dai startup() and disabled with
 					  clk_disable_unprepare() in dai
-					  shutdown().
+					  shutdown(). "system-clock-frequency" 
+					  can also be an array if more than one
+					  clock is described.
+- clock-ids				: An array of clock ID integers,
+					  preferrably defined in DT header.
+					  Each entry corresponds to the same
+					  index postion first in "clocks" and
+					  after the end of clocks array to
+					  "system-clock-frequency" array.
+- clock-dirs				: An array of integers describing
+					  clock directions: CLK_IN (= 0) or
+					  OUT (= 1). Entries in the array
+					  refer to clocks in the same way as
+					  in clock-ids property.
+
 
 Example 1 - single DAI link:
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
