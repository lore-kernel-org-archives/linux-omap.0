Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50195427F4;
	Tue,  8 Sep 2026 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874429; cv=fail; b=iup8w9YciB3QLqk7CV5x8C9r3xVZPRq48mkkblaTICjRYVN/3s7O7tUBShdG9oRhNs7IG133e1iPmXFURXCGKf8IX+5TsUattfSharBu7srkblXG8GrBDUsgBDbuhuysOSpWbuQojzArTi8pHp18C0MBqxgOZ/wEwB0ql50WLbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874429; c=relaxed/simple;
	bh=w037SQnPopZStC335sgre0FdEchqYHc3VfbeT/VaBlk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X8Rxit4+TMZlLejcj50XhWypt/uXZEu7Oxz8wFI9JHsa4QRM/g9FxoF4XDO2MyqNRHhtVWkJMk34JR/q6Ak8mLADg823fi2Gg+cra8E+cjD8AuaF8h/cyIYrywLuE5jWk0xHmaOtgRFRmsf/VsqzY5UykYibCEn0geEqKaDqLN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDBDk89P; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDBDk89P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788874421; x=1820410421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w037SQnPopZStC335sgre0FdEchqYHc3VfbeT/VaBlk=;
  b=HDBDk89PSYso3utahA7dBi4xybe5MxmjvGiwSfFROJcigyMYpyUbPVb+
   xCDM7rP971GUB4DmLQhW5msrKmlbK99vg2hYx2ty1lWT6KJRmulStVJKX
   MWh3b6RUFNyjQ2MJmTnbY5OQM6HwEUrvjTWM6FKECGbKzvxuoDkXCjVw/
   QiiCXXa94wSUlhQQZkNZ42s9TM/rZHS3geIaoaMmqmUW1luewF+moILz1
   yJgwtt+KKG9YcI6Z0RCXE15qKzPJpB8NaqgRQ/OsfJxfmKuBDqA/9BPY1
   YIZV8TE+vJLET5pi9cDKb/Y6mWYNoxYQkBTZHxwmyscNXNsT7VdrWGTLy
   w==;
X-CSE-ConnectionGUID: Uqe4/sNwTuuLMSh9XEpEaQ==
X-CSE-MsgGUID: OG65ek0ETZabrc+13M7dNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89148905"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="89148905"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:33:32 -0700
X-CSE-ConnectionGUID: 0gQuASwsS+ilsuf6DStnWg==
X-CSE-MsgGUID: 8uIPbpYkTQuBYCe5TzzDHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="267755251"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:33:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:33:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:33:31 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:33:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVZ4aFphJC1zvZnLfp0y5u71hN/JV6SNhqPJ6xQsBOZgsKBIFKiagRKSKGYNZHwbmxL/3JxjxDd7J1/12EQ8vUBPZGVvOuIWiQptz/7PqKjD8S9jL9vtf8MG0rT8Atse6ygylN6VRxa0HT7XRSQa5QygFkgrJ8kGyEomFjPbfy6JHQzZY1NiGCGSnaIqmANO8ehHFLqODuZ4SBskQ962QJx3LDd1L5ZtYOaHynUA7wpxmAX3GO+oes7OG472cF63cg8teVy0veM6oFj0pJ7vjR4lZWWxu6k1U0N3d/4+/Mcc0CFzLlem3/sapvYuIz1aNBcmtUjvWyWajOccOgA47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBFNVj2kLlU69sIJYvOKKWz0Sx+Dkf5W3Wxl62ossz8=;
 b=PrxlAt1lVVVjvPGd/vPCd3JcQ3zps1cPit/+P3GzrCODuUiQAL3+uiUw0YqyJgEih03q4qwSzfu9r53yVRvomFUw9QEeV96uar+WHfZ4ZMIQRZXQNKLhMED/JLlNF0GUkIBC8z0FmLMuYMZL8INxVC9/3qJkey3FhTZjYGSQgKd09MLRuGIyl0w4JBvY5nhmIvlad2iFKd5beo2yL5mBJrsaH12Zf260oV7lQfgRdJNskMVzhwQIdXOjSZBGwlYPA7I7V3ymLhSYio5TyNe6nZm8hnYwCXfikPyYKBIZxAsr+1qXTNaxiMMNikhIedKVg0tDsvB3NelyIDN9uEQVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB7832.namprd11.prod.outlook.com (2603:10b6:8:f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 13:33:12 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:33:11 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
	"dario.binacchi@amarulasolutions.com" <dario.binacchi@amarulasolutions.com>,
	"mkl@pengutronix.de" <mkl@pengutronix.de>, "mailhol@kernel.org"
	<mailhol@kernel.org>, "msp@baylibre.com" <msp@baylibre.com>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>,
	"jonas.gorski@gmail.com" <jonas.gorski@gmail.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kurt@linutronix.de"
	<kurt@linutronix.de>, "hauke@hauke-m.de" <hauke@hauke-m.de>,
	"chester.a.unal@arinc9.com" <chester.a.unal@arinc9.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "ansuelsmth@gmail.com"
	<ansuelsmth@gmail.com>, "linusw@kernel.org" <linusw@kernel.org>,
	"luizluca@gmail.com" <luizluca@gmail.com>, "alvin.sipraga@analog.com"
	<alvin.sipraga@analog.com>, "clement.leger@bootlin.com"
	<clement.leger@bootlin.com>, "justin.chen@broadcom.com"
	<justin.chen@broadcom.com>, "dlan@kernel.org" <dlan@kernel.org>,
	"rogerq@kernel.org" <rogerq@kernel.org>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"rjui@broadcom.com" <rjui@broadcom.com>, "sbranden@broadcom.com"
	<sbranden@broadcom.com>, "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "opendmb@gmail.com"
	<opendmb@gmail.com>, "andrei.botila@oss.nxp.com" <andrei.botila@oss.nxp.com>,
	"wangruikang@iscas.ac.cn" <wangruikang@iscas.ac.cn>, "amadeus@jmu.edu.cn"
	<amadeus@jmu.edu.cn>, "kees@kernel.org" <kees@kernel.org>,
	"tmshlvck@gmail.com" <tmshlvck@gmail.com>, "c-vankar@ti.com"
	<c-vankar@ti.com>, "horms@kernel.org" <horms@kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
	"nora.schiffer@ew.tq-group.com" <nora.schiffer@ew.tq-group.com>,
	"v-singh1@ti.com" <v-singh1@ti.com>, "oss@vassilevski.com"
	<oss@vassilevski.com>, "haokexin@gmail.com" <haokexin@gmail.com>,
	"alex@sverdlin.org" <alex@sverdlin.org>, "lgs201920130244@gmail.com"
	<lgs201920130244@gmail.com>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "spacemit@lists.linux.dev"
	<spacemit@lists.linux.dev>, "linux-omap@vger.kernel.org"
	<linux-omap@vger.kernel.org>
Subject: RE: [PATCH net-next 24/33] net: bcmasp: Remove comma after
 sentinel-entry in match-table
Thread-Topic: [PATCH net-next 24/33] net: bcmasp: Remove comma after
 sentinel-entry in match-table
Thread-Index: AQHdPCeKBSwgpc1pS06aFMpAiLgvX7bEtGPg
Date: Tue, 8 Sep 2026 13:33:11 +0000
Message-ID: <IA3PR11MB8986ECEFACA574777AADC435E5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
 <20260904043724.2955444-25-s-vadapalli@ti.com>
In-Reply-To: <20260904043724.2955444-25-s-vadapalli@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB7832:EE_
x-ms-office365-filtering-correlation-id: ae12aab5-b457-4c03-6621-08df0dadba70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006|921020|38070700021;
x-microsoft-antispam-message-info: hw8kdjPtnPPZG3Y3T1H6o/QF0gzBz+xN9XDHV4anfVfFcuLJxKQ/TlhmmMLuy8x5vtdPbr2fQvoLlXEZ1mC87LA65eJmmNhzSoZZpAEjJeR8/sRighdmwDWlTpwhH8iWzVH5VgAs8AxEdXOFzVO04PfxOeUqw+qQZzSOPCo6GF1VLf/AbwabXWSLExHA2bf7ZrZ9olzFDI8VFGX+8GcZa8vbynubSRoXSnfx5Fyci6SYOiekyoZicSQkuAtKhwl6Mt90ZBMtyu6dd4TYAWfCIiUEmZbrVP8LPlIohP0vnDpgk/QYl4yu9P9M+Z0GQPuo1uk+p+1btdz5G2+wCAAHWZkpc9oolSsgnbcKB9mXshvsLZsDTWBdNBKJ3sbHEvyscD5NgxNu2WiSdLk7bcblee9Fh/KwOYSyZ2Bh8M5gsuwqKiNhib8VKV711WaXpbPuFkSS2JyO3XGE5twzp9bCM+a+xdLWHrcp1lCDcH2qCl1UxPB+HvhMkTk3VCCHpCvDtM01f4zc5mxBZbFtp2MyrLUODg21+hx38hP9VPzWYyirFnzt99WrSdKoOkF/anySrrkyLx0+jun9VIsH+tGvZjs847IFrM4BRz5FrFnxw+CdltVZVa0G58nAPridSDKpb/oCEId6sCgzO5v4sXolK7ziDPWkd5DWMut8myTf4PO9DXWCLoou+FHbuU2BaElzSgPIU2K7iAV1CZI0zXCZCAvyHlIheHp3sw4EJoXjgiBKdd6RJFwMIhWYuujVQfgg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5x4VDUIPtziJ+lyRqm7W0MXB7T68QKBc+6ZVDDvDjm8kAmmZR8FZzirgfZ59?=
 =?us-ascii?Q?bi65sE60iAhLJaKMwoTkBjlJ8FD2c1bPnwQwuEOpoBuq8WHvOxs7HFQ1XZIZ?=
 =?us-ascii?Q?HvT7YHeI+Pc+IK1zzFYQ8PN0nrd51f16wafhKYfSVmyOFJV892LI77RYQcGn?=
 =?us-ascii?Q?xwpM9pggsJ0/rbk9ApJv6oSTZxlDz76ATDhr1EEgWVTt1u929fpSlaNoJa6I?=
 =?us-ascii?Q?JycBD/tW4RgumOMIrlXv6wWhApw+MoF2k+veF4lt+dcHlh4Le+zLOuZuM+4C?=
 =?us-ascii?Q?B3JajVY+0R9w+zk7+0X+s+3GfaFnFQssP+fgy/bpnhZjLqFMVym+9yIJS6Cy?=
 =?us-ascii?Q?qLMZ00MHmROb28GpfFEFccKuaL+0Vp3ejCMNLBuxC8xA5k1xArijN8KYyWAP?=
 =?us-ascii?Q?e2szXKVMkMxJoCPuqnEzMPY4axSmKNPRD2qapZd6RHucSPSSk1m1a16nrnGb?=
 =?us-ascii?Q?FAjUOvoRdK8msfx7Pgz4zr/h0bpmupNMXTkLJSr/x18T6J7FzBkU+pMdJuag?=
 =?us-ascii?Q?ZeTIt19VCP69PCev9N5iiE+tJTqersuhyM7Cfsul0wWxGRslr4HHZ9rxy5We?=
 =?us-ascii?Q?Ed1dEI1I5ZYxb2CP/4Q9nokPuzSQJSIUsSGmuzdljayZlgCnfFG+WV5JV30P?=
 =?us-ascii?Q?6GIAbtFrUe9II6kS39BMX0XQTxr4NleqchWYXJv1jCoz7HfJp9hNuEcDWWuF?=
 =?us-ascii?Q?bTV/q6kagp5QGrdP/LAonQHZr3qfTc0wuyrDNbXygHYCfzzcVC7QDiRLKXpI?=
 =?us-ascii?Q?k7uo+l/n+Y60CW7aEJDQHieWkWyQ0pL3rkXm+61/B6XjAoRWQVCkCM1AXyom?=
 =?us-ascii?Q?7N0GteaVymo/Qw/Aw02vQqZka+2QJv1tCJuFr3A1z0XC4fhWeHRud73/3Au6?=
 =?us-ascii?Q?IeqF4MO66QInAzOSVVkqIGaiCmDt+AHFpaOMZMBJ7+pL3FqK331I7r+eGT/M?=
 =?us-ascii?Q?b7YiNhHpw0jjatOcmFzPB5QAvbzy12BGxpPBmG9Boq91IovxAGsmrWqKhJbZ?=
 =?us-ascii?Q?+xoT93gw+8SIHXflafBo1oJ7c1inFf8X9Tbu1mqECQ+WJS1w94+KV+PpRAk+?=
 =?us-ascii?Q?Ul+zA0njLmJrUKsNuWdJyJ9BAhxpe7pCr5iNjn06XlZtLMQIubzxBWOwrAm6?=
 =?us-ascii?Q?M/m5c+IRwSj0b34+cuP0P0Z/jwHypo5O0jwOCo+kxgIpj6rROJHsPRu4b4/b?=
 =?us-ascii?Q?oe3cyHawXFsHHl/UKeQKizVjZIY0Yzu8bPzB58JW5OCClsO/m3ouo9wUyFSN?=
 =?us-ascii?Q?scq55gbXj73KykJqv0Cr3TvIk2+hLM6pEimv2T8iCJenlVkRBEyJOlDZkrNI?=
 =?us-ascii?Q?hienSJCAFH2pE+sTcyDuzpwJ6UD6Ewaf5hTMctqUcn7C0j7u5+Zfn+UM17D4?=
 =?us-ascii?Q?nGKUvJr+GtSfUzZXKSCnyC/XvCQ7+xZVRQvT4QBuklcc37cZ7hvFlLdWY7sf?=
 =?us-ascii?Q?wPnovXWcOdN/LSJS1EFwtpv82lk0PXlipGO3GS1bJGQTAGkf5/hOB0/YACc1?=
 =?us-ascii?Q?IL6nr5gwX31eaPre4t9I7gY7t/rj/PxTa329ka0oMKS9rd/CFnDL/1ADrnU4?=
 =?us-ascii?Q?XJsIldpONZ1JloiUVPsM8HNnm7LoJ8IsgTKfm0F3CKRlTMH3cczIoxWmjF88?=
 =?us-ascii?Q?7p6f0o+GJMESEh1l43PMjCVdxLR9ysjpgAljEVlZI6+Sx10E0WFkG9nCkpAw?=
 =?us-ascii?Q?edrbA4P9XrvGDUAICAJIqifTPLplmdL+2lJr+7Sd0xvvIMbuMUDM6tXFQA+E?=
 =?us-ascii?Q?hl3oH+7d0YRxwXanj1AcZGyAo46zDNo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wlcc5ISkoypEYVAtCOrg5CDhXGmgp9fFaAA0SrTAhh7YDuoG4LPk+dcarx1vmh2jx9d3SF363/i/woAYg4oTRN/VXUgt5ddMzrNrirDHtGrZDMarFS48bjrnmx8gnSBkppGwlrZyA6p+1tlZXen0PC0yOKyH44NYW17Js0vV+rMit0mwgTiqMYVpZKCFGgmMRg7zqHzOHyPYC2Cyqs5vp4T4zgzYRv6fMxT1Lm+ELsMA3TmZuByaNcHKGPX2EJ6LOi82w+osUMOn38OOadi/+m0f+1r4Eyl6qjztjjY5QO+jwLqHjb9NXJ81wnscQumPLXgdAeIzzPW3C3BQgLUt1A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae12aab5-b457-4c03-6621-08df0dadba70
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:33:11.7963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VR1ptsVnR/Wv6wi69lFixfUtSZA1M8c3Gmdl7MBIvpgpIxU3cMEzYncdJjjaDe3dk3aciGl72eGFpztrpkoGhBITYWgDEw+zS40fKEZUBSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7832
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> Sent: Friday, September 4, 2026 6:37 AM
> To: dario.binacchi@amarulasolutions.com; mkl@pengutronix.de;
> mailhol@kernel.org; msp@baylibre.com; florian.fainelli@broadcom.com;
> jonas.gorski@gmail.com; andrew@lunn.ch; olteanv@gmail.com;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; kurt@linutronix.de; hauke@hauke-m.de;
> chester.a.unal@arinc9.com; daniel@makrotopia.org;
> matthias.bgg@gmail.com; angelogioacchino.delregno@collabora.com;
> ansuelsmth@gmail.com; linusw@kernel.org; luizluca@gmail.com;
> alvin.sipraga@analog.com; clement.leger@bootlin.com;
> justin.chen@broadcom.com; dlan@kernel.org; rogerq@kernel.org;
> hkallweit1@gmail.com; linux@armlinux.org.uk; rjui@broadcom.com;
> sbranden@broadcom.com; bcm-kernel-feedback-list@broadcom.com;
> opendmb@gmail.com; andrei.botila@oss.nxp.com; wangruikang@iscas.ac.cn;
> amadeus@jmu.edu.cn; kees@kernel.org; tmshlvck@gmail.com; c-
> vankar@ti.com; horms@kernel.org; vadim.fedorenko@linux.dev;
> daniel.zahka@gmail.com; nora.schiffer@ew.tq-group.com; v-
> singh1@ti.com; oss@vassilevski.com; haokexin@gmail.com;
> alex@sverdlin.org; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; lgs201920130244@gmail.com
> Cc: linux-can@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> mediatek@lists.infradead.org; linux-renesas-soc@vger.kernel.org;
> linux-riscv@lists.infradead.org; spacemit@lists.linux.dev; linux-
> omap@vger.kernel.org; s-vadapalli@ti.com
> Subject: [PATCH net-next 24/33] net: bcmasp: Remove comma after
> sentinel-entry in match-table
>=20
> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>=20
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> index 972474893a6b..3393b5dcbc9a 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> @@ -1209,7 +1209,7 @@ static const struct of_device_id
> bcmasp_of_match[] =3D {
>  	{ .compatible =3D "brcm,asp-v2.1", .data =3D &v21_plat_data },
>  	{ .compatible =3D "brcm,asp-v2.2", .data =3D &v22_plat_data },
>  	{ .compatible =3D "brcm,asp-v3.0", .data =3D &v30_plat_data },
> -	{ /* sentinel */ },
> +	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, bcmasp_of_match);
>=20
> @@ -1217,7 +1217,7 @@ static const struct of_device_id
> bcmasp_mdio_of_match[] =3D {
>  	{ .compatible =3D "brcm,asp-v2.1-mdio", },
>  	{ .compatible =3D "brcm,asp-v2.2-mdio", },
>  	{ .compatible =3D "brcm,asp-v3.0-mdio", },
> -	{ /* sentinel */ },
> +	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, bcmasp_mdio_of_match);
>=20
> --
> 2.51.1

For me it looks like this PR doesn't clean up anything meaningful.
Is there a different opinion?


