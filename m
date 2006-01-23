From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] keypad refresh2
Date: Mon, 23 Jan 2006 09:35:44 -0800 (PST)
Message-ID: <20060123173544.2231.qmail@web32901.mail.mud.yahoo.com>
References: <20060123170347.GB6263@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-657601475-1138037744=:2019"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060123170347.GB6263@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-657601475-1138037744=:2019
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

--- Tony Lindgren <tony@atomide.com> wrote:

> 
> How about just adding && machine_is_omap_h4() there too?

Ok, attached patch adds machine_is_omap_h4() condition.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>


---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-657601475-1138037744=:2019
Content-Type: text/plain; name="kbfix.patch"
Content-Description: 690037527-kbfix.patch
Content-Disposition: inline; filename="kbfix.patch"

diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index ef30720..4dff4d3 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -299,7 +299,8 @@ static int __init omap_kp_probe(struct p
 		col_gpios = pdata->col_gpios;
 	}
 
-	if (cpu_is_omap24xx() && omap_has_menelaus()) {
+	if (cpu_is_omap24xx() && omap_has_menelaus() 
+		&& machine_is_omap_h4()) {
 		row_gpios[5] = 0;
 		col_gpios[2] = 15;
 		col_gpios[6] = 18;

--0-657601475-1138037744=:2019
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-657601475-1138037744=:2019--
