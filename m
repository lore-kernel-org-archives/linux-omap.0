From: Felipe Balbi <me@felipebalbi.com>
Subject: FYI [chase.maupin@ti.com: TI GStreamer plugin for DaVinci and OMAP
	processors released]
Date: Fri, 27 Feb 2009 22:43:16 +0200
Message-ID: <20090227204315.GM16801@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39797 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739AbZB0UnW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 15:43:22 -0500
Received: from [91.154.126.168] (port=29000 helo=frodo)
	by serv01.siteground211.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <me@felipebalbi.com>)
	id 1Ld9YE-0002sB-Kc
	for linux-omap@vger.kernel.org; Fri, 27 Feb 2009 14:43:19 -0600
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For anyone interested, here it goes

--=20
balbi

--Bn2rw/3z4jIqBvZU
Content-Type: message/rfc822
Content-Disposition: inline

Received: from felipeba by serv01.siteground211.com with local-bsmtp (Exim 4.69)
	(envelope-from <davinci-linux-open-source-bounces@linux.davincidsp.com>)
	id 1Ld99x-0001WB-CI
	for me@felipebalbi.com; Fri, 27 Feb 2009 14:18:13 -0600
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	serv01.siteground211.com
X-Spam-Level: 
X-Spam-Status: No, score=-100.0 required=5.0 tests=USER_IN_WHITELIST
	shortcircuit=ham autolearn=disabled version=3.2.4
Received: from [192.94.94.40] (port=38346 helo=arroyo.ext.ti.com)
	by serv01.siteground211.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <davinci-linux-open-source-bounces@linux.davincidsp.com>)
	id 1Ld99p-0001TO-63
	for me@felipebalbi.com; Fri, 27 Feb 2009 14:18:13 -0600
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1RKGris014787;
	Fri, 27 Feb 2009 14:16:58 -0600
Received: from linux.omap.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n1RKGqbe023473;
	Fri, 27 Feb 2009 14:16:52 -0600 (CST)
Received: from linux.omap.com (localhost [127.0.0.1])
	by linux.omap.com (Postfix) with ESMTP
	id EF5988062A; Fri, 27 Feb 2009 14:16:51 -0600 (CST)
X-Original-To: Davinci-linux-open-source@linux.davincidsp.com
Delivered-To: Davinci-linux-open-source@linux.davincidsp.com
Received: from dlep95.itg.ti.com (dlep95.itg.ti.com [157.170.170.107])
	by linux.omap.com (Postfix) with ESMTP id 861AF80626
	for <Davinci-linux-open-source@linux.davincidsp.com>;
	Fri, 27 Feb 2009 14:16:48 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1RKGmB0017594
	for <Davinci-linux-open-source@linux.davincidsp.com>;
	Fri, 27 Feb 2009 14:16:48 -0600 (CST)
Received: from dlee06.ent.ti.com ([157.170.170.11]) by dlee74.ent.ti.com
	([157.170.170.8]) with mapi; Fri, 27 Feb 2009 14:16:48 -0600
From: "Maupin, Chase" <chase.maupin@ti.com>
To: "Davinci-linux-open-source@linux.davincidsp.com" <Davinci-linux-open-source@linux.davincidsp.com>
Date: Fri, 27 Feb 2009 14:16:46 -0600
Thread-Topic: TI GStreamer plugin for DaVinci and OMAP processors released
Thread-Index: AcmZGFBJxn8aZakMRFuy4D9TW7azLg==
Message-ID: <131E5DFBE7373E4C8D813795A6AA7F08027E9AAC48@dlee06.ent.ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: 
Subject: TI GStreamer plugin for DaVinci and OMAP processors released
X-BeenThere: davinci-linux-open-source@linux.davincidsp.com
X-Mailman-Version: 2.1.4
Precedence: list
List-Id: davinci-linux-open-source.linux.davincidsp.com
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request@linux.davincidsp.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source@linux.davincidsp.com>
List-Help: <mailto:davinci-linux-open-source-request@linux.davincidsp.com?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request@linux.davincidsp.com?subject=subscribe>
Errors-To: davinci-linux-open-source-bounces@linux.davincidsp.com

All,

GStreamer is an open-source multimedia pipeline engine.  TI is pleased to a=
nnounce that we have created a plugin for GStreamer that contains several e=
lements to enable the use of TI hardware with GStreamer.  This includes ele=
ments to use the DSP or other hardware accelerators to encode and decode au=
dio, video, and images.  This is a base port to enable developers to use GS=
treamer on their embedded devices to allow for a more multimedia rich offer=
ing.  The code has been designed to be highly portable between TI processor=
s.  We currently support the following processors:

- DM644x
- DM355
- DM6467
- OMAP3

On those processors we support playback of elementary streams as well as tr=
ansport streams, AVI files, and mp4 streams.  As new processors are release=
d we are adding their support to the GStreamer implementation.
=20
We have partnered with RidgeRun for support.  The support model is that cus=
tomers can use open-source resources to solve problems but if they need mor=
e detailed help, custom features, or help in productizing their offering th=
ey can buy a support contract from RidgeRun.

The project is hosted on a GForge server at http://gstreamer.ti.com.  There=
 is an initial 0.99.00 release available at that site which will support de=
coding of audio, video, and images as well as the encoding of images.  Supp=
ort for encoding of audio and video is in the development trunk of the repo=
sitory but has not yet been fully tested.  For more information on this pro=
ject please visit http://gstreamer.ti.com=20

What's coming:

1. Support for DM357
2. Support beagleboard (using Arago/OpenEmbedded)
3. New release with tested audio/video encoders


Sincerely,
Chase Maupin
Software Applications
Catalog DSP Products
e-mail: chase.maupin@ti.com
phone: (281) 274-3285
--Bn2rw/3z4jIqBvZU--
