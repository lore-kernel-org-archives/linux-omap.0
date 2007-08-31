From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] Updated ARM mach-types.
Date: Thu, 30 Aug 2007 19:02:38 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701A9127B@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This patch is to fix OMAP 3430SDP machine ID by upgrading to latest=20
mach-types from:

http://www.arm.linux.org.uk/developer/machines/download.php.

Signed-off-by: Syed Mohammed Khasim <x0khasim@ti.com>

File:
 arch/arm/tools/mach-types

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--- linux-omap/arch/arm/tools/mach-types	2007-05-16 14:32:40.000000000 =
-0500
+++ my_linux-omap/arch/arm/tools/mach-types	2007-08-30 =
18:42:48.000000000 -0500
@@ -12,7 +12,7 @@
 #
 #   http://www.arm.linux.org.uk/developer/machines/?action=3Dnew
 #
-# Last update: Fri May 11 19:53:41 2007
+# Last update: Fri Aug 31 00:38:19 2007
 #
 # machine_is_xxx	CONFIG_xxxx		MACH_TYPE_xxx		number
 #
@@ -266,7 +266,7 @@ stork_egg		ARCH_STORK_EGG		STORK_EGG		24
 wismo			SA1100_WISMO		WISMO			249
 ezlinx			ARCH_EZLINX		EZLINX			250
 at91rm9200		ARCH_AT91RM9200		AT91RM9200		251
-orion			ARCH_ORION		ORION			252
+adtech_orion		ARCH_ADTECH_ORION	ADTECH_ORION		252
 neptune			ARCH_NEPTUNE		NEPTUNE			253
 hackkit			SA1100_HACKKIT		HACKKIT			254
 pxa_wins30		ARCH_PXA_WINS30		PXA_WINS30		255
@@ -1148,7 +1148,7 @@ aidx270			MACH_AIDX270		AIDX270			1134
 rema			MACH_REMA		REMA			1135
 bps1000			MACH_BPS1000		BPS1000			1136
 hw90350			MACH_HW90350		HW90350			1137
-omap_sdp3430		MACH_OMAP_SDP3430	OMAP_SDP3430		1138
+omap_3430sdp		MACH_OMAP_3430SDP	OMAP_3430SDP		1138
 bluetouch		MACH_BLUETOUCH		BLUETOUCH		1139
 vstms			MACH_VSTMS		VSTMS			1140
 xsbase270		MACH_XSBASE270		XSBASE270		1141
@@ -1299,7 +1299,7 @@ xp179			MACH_XP179		XP179			1290
 h4300			MACH_H4300		H4300			1291
 goramo_mlr		MACH_GORAMO_MLR		GORAMO_MLR		1292
 mxc30020evb		MACH_MXC30020EVB	MXC30020EVB		1293
-adsbitsymx		MACH_ADSBITSIMX		ADSBITSIMX		1294
+adsbitsyg5		MACH_ADSBITSIMX		ADSBITSIMX		1294
 adsportalplus		MACH_ADSPORTALPLUS	ADSPORTALPLUS		1295
 mmsp2plus		MACH_MMSP2PLUS		MMSP2PLUS		1296
 em_x270			MACH_EM_X270		EM_X270			1297
@@ -1367,3 +1367,109 @@ db88f5281		MACH_DB88F5281		DB88F5281		13
 csb726			MACH_CSB726		CSB726			1359
 tik27			MACH_TIK27		TIK27			1360
 mx_uc7420		MACH_MX_UC7420		MX_UC7420		1361
+rirm3			MACH_RIRM3		RIRM3			1362
+pelco_odyssey		MACH_PELCO_ODYSSEY	PELCO_ODYSSEY		1363
+arm920t			MACH_ARM920T		ARM920T			1364
+add_abox		MACH_ADD_ABOX		ADD_ABOX		1365
+add_tpid		MACH_ADD_TPID		ADD_TPID		1366
+minicheck		MACH_MINICHECK		MINICHECK		1367
+idam			MACH_IDAM		IDAM			1368
+mario_mx		MACH_MARIO_MX		MARIO_MX		1369
+vi1888			MACH_VI1888		VI1888			1370
+zr4230			MACH_ZR4230		ZR4230			1371
+t1_ix_blue		MACH_T1_IX_BLUE		T1_IX_BLUE		1372
+syhq2			MACH_SYHQ2		SYHQ2			1373
+computime_r3		MACH_COMPUTIME_R3	COMPUTIME_R3		1374
+oratis			MACH_ORATIS		ORATIS			1375
+mikko			MACH_MIKKO		MIKKO			1376
+holon			MACH_HOLON		HOLON			1377
+olip8			MACH_OLIP8		OLIP8			1378
+ghi270hg		MACH_GHI270HG		GHI270HG		1379
+davinci_dm6467_evm	MACH_DAVINCI_DM6467_EVM	DAVINCI_DM6467_EVM	1380
+davinci_dm350_evm	MACH_DAVINCI_DM350_EVM	DAVINCI_DM350_EVM	1381
+ocearm			MACH_OCEARMTEST		OCEARMTEST		1382
+blackriver		MACH_BLACKRIVER		BLACKRIVER		1383
+sandgate_wp		MACH_SANDGATEWP		SANDGATEWP		1384
+cdotbwsg		MACH_CDOTBWSG		CDOTBWSG		1385
+quark963		MACH_QUARK963		QUARK963		1386
+csb735			MACH_CSB735		CSB735			1387
+littleton		MACH_LITTLETON		LITTLETON		1388
+mio_p550		MACH_MIO_P550		MIO_P550		1389
+motion2440		MACH_MOTION2440		MOTION2440		1390
+imm500			MACH_IMM500		IMM500			1391
+homematic		MACH_HOMEMATIC		HOMEMATIC		1392
+ermine			MACH_ERMINE		ERMINE			1393
+kb9202b			MACH_KB9202B		KB9202B			1394
+hs1xx			MACH_HS1XX		HS1XX			1395
+studentmate2440		MACH_STUDENTMATE2440	STUDENTMATE2440		1396
+arvoo_l1_z1		MACH_ARVOO_L1_Z1	ARVOO_L1_Z1		1397
+dep2410k		MACH_DEP2410K		DEP2410K		1398
+xxsvideo		MACH_XXSVIDEO		XXSVIDEO		1399
+im4004			MACH_IM4004		IM4004			1400
+zevio_1050		MACH_ZEVIO_1050		ZEVIO_1050		1401
+lep9261			MACH_LEP9261		LEP9261			1402
+svenmeb			MACH_SVENMEB		SVENMEB			1403
+fortunet2ne		MACH_FORTUNET2NE	FORTUNET2NE		1404
+omap2			MACH_OMAP2		OMAP2			1405
+nxhx			MACH_NXHX		NXHX			1406
+realview_pb11mp		MACH_REALVIEW_PB11MP	REALVIEW_PB11MP		1407
+ids500			MACH_IDS500		IDS500			1408
+ors_n725		MACH_ORS_N725		ORS_N725		1409
+hsdarm			MACH_HSDARM		HSDARM			1410
+sha_pon003		MACH_SHA_PON003		SHA_PON003		1411
+sha_pon004		MACH_SHA_PON004		SHA_PON004		1412
+sha_pon007		MACH_SHA_PON007		SHA_PON007		1413
+sha_pon011		MACH_SHA_PON011		SHA_PON011		1414
+h6042			MACH_H6042		H6042			1415
+h6043			MACH_H6043		H6043			1416
+looxc550		MACH_LOOXC550		LOOXC550		1417
+cnty_titan		MACH_CNTY_TITAN		CNTY_TITAN		1418
+app3xx			MACH_APP3XX		APP3XX			1419
+sideoatsgrama		MACH_SIDEOATSGRAMA	SIDEOATSGRAMA		1420
+xscale_palmt700p	MACH_XSCALE_PALMT700P	XSCALE_PALMT700P	1421
+xscale_palmt700w	MACH_XSCALE_PALMT700W	XSCALE_PALMT700W	1422
+xscale_palmt750		MACH_XSCALE_PALMT750	XSCALE_PALMT750		1423
+xscale_palmt755p	MACH_XSCALE_PALMT755P	XSCALE_PALMT755P	1424
+ezreganut9200		MACH_EZREGANUT9200	EZREGANUT9200		1425
+sarge			MACH_SARGE		SARGE			1426
+a696			MACH_A696		A696			1427
+turtle1916		MACH_TURTLE		TURTLE			1428
+pxa1916			MACH_MY5910TURTLE	MY5910TURTLE		1429
+mx27_3ds		MACH_MX27_3DS		MX27_3DS		1430
+bishop			MACH_BISHOP		BISHOP			1431
+pxx			MACH_PXX		PXX			1432
+redwood			MACH_REDWOOD		REDWOOD			1433
+dummy			MACH_OMAP2430DLP	OMAP2430DLP		1434
+dummy_board		MACH_OMAP2430OSK	OMAP2430OSK		1435
+omap_2430dlp		MACH_OMAP_2430DLP	OMAP_2430DLP		1436
+omap_2430osk		MACH_OMAP_2430OSK	OMAP_2430OSK		1437
+sardine			MACH_SARDINE		SARDINE			1438
+halibut			MACH_HALIBUT		HALIBUT			1439
+trout			MACH_TROUT		TROUT			1440
+goldfish		MACH_GOLDFISH		GOLDFISH		1441
+gesbc2440		MACH_GESBC2440		GESBC2440		1442
+nomad			MACH_NOMAD		NOMAD			1443
+rosalind		MACH_ROSALIND		ROSALIND		1444
+cc9p9215		MACH_CC9P9215		CC9P9215		1445
+cc9p9210		MACH_CC9P9210		CC9P9210		1446
+cc9p9215js		MACH_CC9P9215JS		CC9P9215JS		1447
+cc9p9210js		MACH_CC9P9210JS		CC9P9210JS		1448
+nasffe			MACH_NASFFE		NASFFE			1449
+tn2x0bd			MACH_TN2X0BD		TN2X0BD			1450
+gwmpxa			MACH_GWMPXA		GWMPXA			1451
+exyplus			MACH_EXYPLUS		EXYPLUS			1452
+jadoo21			MACH_JADOO21		JADOO21			1453
+looxn560		MACH_LOOXN560		LOOXN560		1454
+bonsai			MACH_BONSAI		BONSAI			1455
+adsmilgato		MACH_ADSMILGATO		ADSMILGATO		1456
+gba			MACH_GBA		GBA			1457
+h6044			MACH_H6044		H6044			1458
+app			MACH_APP		APP			1459
+tct_hammer		MACH_TCT_HAMMER		TCT_HAMMER		1460
+herald			MACH_HERMES		HERMES			1461
+artemis			MACH_ARTEMIS		ARTEMIS			1462
+htctitan		MACH_HTCTITAN		HTCTITAN		1463
+qranium			MACH_QRANIUM		QRANIUM			1464
+add_wsc2		MACH_ADD_WSC2		ADD_WSC2		1465
+add_medinet		MACH_ADD_MEDINET	ADD_MEDINET		1466
+bboard			MACH_BBOARD		BBOARD			1467
