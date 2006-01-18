From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] Convert touchscreen to input_allocate_device
Date: Wed, 18 Jan 2006 08:39:32 -0800 (PST)
Message-ID: <20060118163932.15056.qmail@web32901.mail.mud.yahoo.com>
References: <20060118112155.GA16067@two.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1008054942-1137602372=:10746"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060118112155.GA16067@two.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
Cc: linux-omap-open-source@linux.omap.com, Mikko.Soikkala@tietoenator.com
List-Id: linux-omap@vger.kernel.org

--0-1008054942-1137602372=:10746
Content-Type: text/plain; charset=iso-8859-1
Content-Id: 
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by reloaded.ext.ti.com id k0IGddqu012508

--- Juha Yrj=F6l=E4 <juha.yrjola@nokia.com> wrote:

>=20
> Not quite yet. =3D) If you allocate the input device earlier, you also
> have to
> take care in deallocating it in the error paths after it.

Ok. Please check the attached patch. Build for OSK.=20

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>


---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
--0-1008054942-1137602372=:10746
Content-Type: text/plain; name="tsfix.patch"
Content-Description: 1479429603-tsfix.patch
Content-Disposition: inline; filename="tsfix.patch"

diff --git a/drivers/input/touchscreen/corgi_ts.c b/drivers/input/touchscreen/corgi_ts.c
diff --git a/drivers/input/touchscreen/omap/omap_ts.c b/drivers/input/touchscreen/omap/omap_ts.c
index 5916245..f55ea05 100644
--- a/drivers/input/touchscreen/omap/omap_ts.c
+++ b/drivers/input/touchscreen/omap/omap_ts.c
@@ -133,6 +133,12 @@ static int __init omap_ts_probe(struct p
 	int status = -ENODEV;
 
 	memset(&ts_omap, 0, sizeof(ts_omap));
+	
+	ts_omap.inputdevice = input_allocate_device();
+	if (!ts_omap.inputdevice) {
+		return -ENOMEM;
+	}
+
 	spin_lock_init(&ts_omap.lock);
 
 	for (i = 0; i < ARRAY_SIZE(ts_devs); i++) {
@@ -145,8 +151,10 @@ static int __init omap_ts_probe(struct p
 		}
 	}
 
-	if (status != 0)
+	if (status != 0) {
+	    	input_free_device(ts_omap.inputdevice);
 		return status;
+	}
 
 	// Init acquisition timer function
 	init_timer(&ts_omap.ts_timer);
@@ -159,15 +167,18 @@ static int __init omap_ts_probe(struct p
 			printk(KERN_ERR
 	  "omap_ts.c: Could not allocate touchscreen IRQ!\n");
 			ts_omap.irq = -1;
+			ts_omap.dev->remove();
+			input_free_device(ts_omap.inputdevice);
 			return -EINVAL;
 		}
 		ts_omap.irq_enabled = 1;
 	} else {
 		printk(KERN_ERR "omap_ts.c: No touchscreen IRQ assigned!\n");
+		ts_omap.dev->remove();
+		input_free_device(ts_omap.inputdevice);
 		return -EINVAL;
 	}
 
-	ts_omap.inputdevice = input_allocate_device();
 	ts_omap.inputdevice->name = OMAP_TS_NAME;
 	ts_omap.inputdevice->dev = &pdev->dev;
 	ts_omap.inputdevice->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);

--0-1008054942-1137602372=:10746
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--0-1008054942-1137602372=:10746--
