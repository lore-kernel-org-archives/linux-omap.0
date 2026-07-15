Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD10395AF5;
	Wed, 15 Jul 2026 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784146180; cv=fail; b=OM803ADLlglkjPaXmgN1J7nMuFrdPu+Kkl0bCAg570pvOUvxnWh0pB9EKTmBvMbAWk4Y/0SbsrPUZPOZN9pTpvPHvTvAwjX4tWeHPUNQ0Yv3ygi6Wb5iHJCL5YcVAcOPo/uN43QMJLrMvjSxHxYkIMdxAAQA1J0PMBmqWvhmfa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784146180; c=relaxed/simple;
	bh=MBz2KZK9+e7jpMIRyxnkACMT2Kad762Lq9hO73R+4wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=quxAK5lnX2A5HZJoMtzoovEqy8bkQzEVR9Dd6/TLowrXtAAj0SkiVH3QY3vn62TxXR3K1C5BmDe+G4oC8kDJ6Cec3nFXomKcAR+eRZFLON6Bjxyl9JOp+vdzmOBAOFNPwEOJQIz7NYhthL0iMBeLn7dehHlDztsC4DiqzP+Vnq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pSfmfcC/; arc=fail smtp.client-ip=40.93.195.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pSfmfcC/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NG0gxBMHS0wvRtT86cxTIGL/6aS0hCLIDtyuD87FZMyF/QhyAcVYl9yC9FG5OKalTY/oUbh8iN8wVBjdnU76Dp3jAlSSEitc3pM6Tq/I5SPbhZI5vlCI/gqEOjWdkOcsc3rtFyD/Nks9l6H5rpxiwfJMV2wukHrF+cbwd3YBtpIJR6cVXQuHEOvRBqWgDxui/J6SA+n9boCANM6jKgP0PcLtkeYpY1flrcLcCgOgL0NY8RQOyThvONSJFTh59sneO7UXxFiGotR9DByrlrJILzJQrVnu3b4yX4Xu8O5fCJswggXrTMGUkzHyJI87GG3432P3surPgEeLPAZOzvyBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iz7XmmX24Tx0vj9ovwY/pe6OU0HN8uVAdrXrOF9QOJs=;
 b=RO0x3/Y0my8HG/iHtN61dPy+67+ak+jqLFj7iAMBSew4bRyCG50gYcQ9F+72vke6o7zSo+9bA9eAM1JfPSJi5DFMmlZZYkjTKny7IxhkMgUDHNUeLwTgnk17hQxbXHi2G7dVcoYaixxe8CmTG14O0kcoVgMNrwYCOvyUmp+0pM38PDDJdqcw0ZAC2b5C4MEI/WzXLTI2/sRp1AArui9mVVbziNlcCU6ms/wrLsK6V4sWvxQ+1YWI0jQTG2fNHP74M0k9VPsVK7yjJgunXwZeXgx7CMSZWGuAM9vlIXK9y5z5EHCG19dzDb6RZrIBOfAPZXxChjek2LBwm0dQMW53DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iz7XmmX24Tx0vj9ovwY/pe6OU0HN8uVAdrXrOF9QOJs=;
 b=pSfmfcC/lkXddvqri1BMdaKFH3xNC+xcGCbBrYVopO9ofw32N+d3HQ+DLeYkCmUlNCGkrtb6TzLVcCtSsiQDSwLVZvineJ1NazAbEJxNxbQa9qMXy7f+HOKAOaJdQtKe+4CjekdtayKQFTvSSkshq6CfUQdM9aw2guAi9tZDX6miOZgerY3AJapoJ9mL4cpEdxucuPSnWfXNoalOk481wUMkVsSaN+k5qAJSN+IuzbeQDFFuouUUG9bz8B7k8U/fshOaFRi8oNzCbu/OPOdx8hDnkr7hNHn5x9hSePxMGTsCRUIx/tHohomgKPp4Y1r41rFEfiphFFbE/pygYKoJPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 20:09:23 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 20:09:22 +0000
Date: Wed, 15 Jul 2026 16:09:20 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Srinivas Kandagatla <srini@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	"Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
	Kalyani Akula <kalyani.akula@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Joshua Kinard <linux@kumba.dev>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Ronald Claveau <linux-kernel-dev@aliel.fr>,
	Salah Triki <salah.triki@gmail.com>,
	David Carlier <devnexen@gmail.com>,
	Achim Gratz <Achim.Gratz@stromeko.de>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Patrick Wicki <patrick.wicki@siemens.com>,
	Markus Heidelberg <m.heidelberg@cab.de>,
	Markus Perkins <markus@notsyncing.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
	Chen Ni <nichen@iscas.ac.cn>, Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
	linux-omap@vger.kernel.org, mfd@lists.linux.dev,
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, linux-rtc@vger.kernel.org,
	linux-sunxi@lists.linux.dev, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 0/8] nvmem: make reg_write() take a const void *
Message-ID: <alfo8Mobje173POp@yury>
References: <20260715175229.24672-1-linkmauve@linkmauve.fr>
 <alfZNQGcX0Z68eto@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alfZNQGcX0Z68eto@ashevche-desk.local>
X-ClientProxiedBy: BN9P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::28) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 739916a5-6cc9-45f8-75a5-08dee2acf5ec
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|3023799007|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
 kjktUjFr3YHIAd9HOXDnj8X0kzTKzPsKlrEb74pmZzz1oKd0R5473G9G4H9nXkfurcWsAVRNiIn+MGejIXnY2O1Q9TwJteO87bui/ox5Wpc+e4jyVpTYN80+KiaUHDL+RENozmOJq9z7theAUXthgs4WaAmQcX4ZKMLpAiCwK2d8WQm6X7T7i7YqKR6rLAsBZIQNQoSZE6byz6rxvyQTn1Y9L1y6JKG+OYOuPbfkDaZE+/x5bnk/CPtcCDfDzlG99snvWoUn3nLkZCQq/jnAlqwcJcoxJfworBmDUkScxPe3kyFfst7OOgIkhQbBanycl2jHlLF+kyTL+iFXrQo7JxQSqyOuPSgoJ0WqHOXU3en3jV0gUayueLnV/fPKopOoeTZ3hGOxYUXTwZGIhGHP3He8s2cRXhV+aU7EwiSucaeD9hgBouNZaeMsLRoX2LXGXcH2e6hqyzJ8cMIJJeqqUXcVYvsAsX+QaVhSDsB820rmUDkOUjW3B+mteywq3BauR5IGy0rZ7neI8JQzc6p0iK8uiJLUfwzV+cpWuqz/lma0b5UmCP6isVuH6/s6NCOvsgmtHPE9CaD+G6qlj6LGDj4pOVOShWklvd8ysc6OYnsbiCWpsQvKSf37uBO0NHdDZdlgeiMCAbj+CFFH6B61aRc7N4xbCnC+Ue2lgYi2sbk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VnZndmVmamFCaFMyMEY0MzRWNElKY2VqWStWT2U0R09kRGl5Uy9qZ3RpUFZ0?=
 =?utf-8?B?dm1VZlBCd3ZpRTdLN3BIeEMwNURsanZzNjZhNDVmNjdLUkp6eFJpTWJyeGd0?=
 =?utf-8?B?V2lLRTFjR2h4bnpsdE9QOXRuekhJYnZ4djlORjdhQTQwRllvblRoNTJoNlJN?=
 =?utf-8?B?a1JsMHJXYmhTVHNhdFhhVjZtclVGRmNyMmwxRFpVZGJDRzJhLy9QVS91OG9q?=
 =?utf-8?B?c0ZQVkRSYnFxVEFsaHM5aGpWR1d4QzZCZUJNeHY1a2tsLzZrb0RJU0UwU2hD?=
 =?utf-8?B?c1crQWp0Yk1nemx4SjVoeVZKZjRMU2szWGFqNTBJRm4xV0t6eXZCZHg0NzB3?=
 =?utf-8?B?YlVOcDlNajJIaXBTQUVRZWJFb2F6cFd4YXVWOHM5NnBpZ2hvQ0Y4U1BvU2wy?=
 =?utf-8?B?T2d4VVY5S2g4b2dJaXpTNzU4R1VLdjJSMUFjMU41VElLbk55WmZjc2kxVlRm?=
 =?utf-8?B?Rk1JNTFtWHRqZFpQeWZXbGdjNGVNSWtaS3lLVmpWaFc4L0x0ZmNQMEJvV0ho?=
 =?utf-8?B?OEhpSTcrL2hJdXIza3ZSSXpYRVJIR3lJZDVzVEZsN29mdnF2ZTl5UzhFcjJK?=
 =?utf-8?B?M0RMbzE4U0p0R0RrUHVzVVh3Q3pjTlppaGFyMFZHamhIVkhyRElDdE1xb1Fk?=
 =?utf-8?B?NnpLZmR6VG9hV0cyYmE5bHU5ejI5cGtHZEZOK1ptb2hzSUtJNTk0UFNPZUhV?=
 =?utf-8?B?U1BFSGovSGdjaW8wMEdhTEQ0ZHNCcjhJNkYzTHlLdXgzMmlvLzcrbmJLZHdL?=
 =?utf-8?B?Y1Q0QVZ2d0lFY0pSMkpoWVR1dGtKZlFjMGRheTlBMU42U2N1bXlmN1oweU83?=
 =?utf-8?B?ZmRhd0pzWjlCV2R0d1VYaS8vUSs1UklPdFFGb2JtcktTcy9KVkpHbFpkV0FO?=
 =?utf-8?B?aithWkwrbmMybGdtTXk4am9yUmRwZGRMN21hQmduakdTSTcwblJnYXJyOG52?=
 =?utf-8?B?T3hvdGkrVXk3bWJyWThPMXVVS3I5V0pwSjlMcStKNWpUL1JmQXRlaVhHSTR3?=
 =?utf-8?B?MDVWVEorYXhmVzlaMDR5b1JOczJoMmFaai90aDExbHFxY0ttVEVObERZMm1Z?=
 =?utf-8?B?RzI2UC9kVkwzL2FFdHhaanpWMFNZSWFGOUtLLzY5R01pNStnM0hoRm5mL2hG?=
 =?utf-8?B?ZmtBQ2M3RUZ4L1B3NGtzOUxpT25TWCtoQTVUN2tKL05zMnJ1cWpNVGpyYUJq?=
 =?utf-8?B?elFpaGJ5SlFselpwRHhUQ2RZNitFY3l1cjVpZ1N0UEFZSEwvOWQrUE9qbGhB?=
 =?utf-8?B?R3FhQ3dqenJRSk92QlZGQUVJSEJRMkdMenc0djduOE5lNlQ5aVNpR3FpWlp6?=
 =?utf-8?B?L3hoOThQRithbFB1UVVGQk5SUzg4M0dmb0ZHZXl6TkhqRVVDcjVET3hRazVJ?=
 =?utf-8?B?c0J6dGNPQStYdlljRWZhNTVySWN5SnBMU1YyZUF6MjRRQ2Y3SWR1RXNIR1NP?=
 =?utf-8?B?eDhkcEJ5MVQweE5kcUl5MnkvNFpTejF6Q1lGb3BKYzNwTy94dDBPSEovSlVX?=
 =?utf-8?B?ZDFoRFhXbXdkRDZ6WjZpVnZtblcreEUxOTdtZmNGays2bEVoOTVUazI5VSt5?=
 =?utf-8?B?U2QyU1dLbER2WjJIK2VIeC92WWFuWWRBR1YyZHJSWDg4eVYzSUU4dVpsNUVm?=
 =?utf-8?B?Q0Uva1ozbDRsTWVQM043bWhXVEh0SWo4UjZUbG85ekIyNGJYWmlndXdZZ3hT?=
 =?utf-8?B?UFVMRklCdVhGZGtsMllQMEdiR2ZzVURndmF6azB0Uy9zL3FxRUJIT2JNekI4?=
 =?utf-8?B?QXFjMk1Xem4rZC9FWUhMcFNDUWEwVXFRNEUxMjMvRGJQTk9HaStiOTJ6VlFB?=
 =?utf-8?B?N0xWTzR1QkFNaWtFUlhKVHJSMDgzWUt4dHR3MFFnVFlBUDVxQXcxY1ZiZHgr?=
 =?utf-8?B?N0x5ZWxtM3hnVEx0LzRuZDVZdnVVU3BOYWhLSHYvK1RIRWJuek8za1RwRUVF?=
 =?utf-8?B?NE5GQi96aGRqY055ZDd0dVZIKzROL2g3YUFRNllMUWljVWhHUVU2Q1hEamR3?=
 =?utf-8?B?UnZOaTBiRVFXZkIzUWtGL284U0hVcFI5MCtUNVlENDl0SmZlcDBzM1M0WUVt?=
 =?utf-8?B?eklTamZMOWk2ZktXY0VSMENZM0VuRDM2VytjTTYzU1MzcjYwK1NGR2RkZ3JM?=
 =?utf-8?B?a2NNd011cUpxUFc4VW1xK2Nxc1V4cnd6Q1pwLzJVTmI3UTMzYzdmcCtmOEZo?=
 =?utf-8?B?WEJDVmh3VllNNVZ3czNtRzM3UkhlQjhtS29jYWpXVEJQZkt0Tmh1YmtSRi9r?=
 =?utf-8?B?eWFiTXVsK2hwYVVmMXB3NXUvajNZd0NEdzl5L0xBbE1uL0RRbzBGOE9pZmQy?=
 =?utf-8?B?djRoY3hpL2dBWjNwNFVQbmlHYzE1aFg3RGJsOGtvNEp4eUI5YmFRQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739916a5-6cc9-45f8-75a5-08dee2acf5ec
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:09:22.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imKJ2ftKfyu26Ucy9tRvrhtrWr4sGKGFzteveH/jcXLL1Ms1j6mHohHKVtbD2KiFZdyqz5HKF+ud7u1xeIA1Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342

On Wed, Jul 15, 2026 at 10:02:13PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 15, 2026 at 07:52:16PM +0200, Link Mauve wrote:
> > This callback used to take a mutable void * for no reason, which causes
> > the compiler to be unaware that the val buffer should never be modified
> > by the callback.
> > 
> > This was found while drafting the nvmem-provider Rust abstraction.
> > 
> > I’ve split this series based on the subsystem each patch affects, but I
> > think it should go through the nvmem tree in one go after gathering the
> > acks from the other subsystem maintainers.
> 
> It's an option. The other option (and often we go this way) is to introduce
> a new name, convert users, convert the name back.
> 
> See, for example, how GPIO subsystem changed a proto of .set() callback.

I agree with Andy. This should be a well-narrowed bisectable series,
so please follow his suggestion with renaming.

> > I’ve been told previously to not include too many maintainers in Cc, but
> > I don’t know which ones to remove from the get_maintainers.pl output, so
> > I’ve still included everyone, sorry about that.
> 
> With this, rather standard, way you will fulfill the above requirement
> automatically. Also you won't need treewide change to bother everybody
> with this. And also increase the chances to go in (maybe in a few releases
> span).

If I feel the recepient list is too long, I have a couple home-brewed scripts
for it:

  $ cat add_maintainers.sh
  #!/bin/bash
  
  line=`scripts/get_maintainer.pl -n -f --separator , --no-rolestats $1`
  
  sed -i "/^Subject:/i To: $line" $1
  sed -i "s/>,/>,\n\t/g" $1

and

  $ cat addm.sh
  #!/bin/bash

  for f in 00*; do
  	echo $f
  	./add_maintainers.sh $f
  done

So, my approach is:

1. Run the ./addm.sh
2. Pick maintainers from each patch, and put them in the cover letter.
3. Trim cover letter To list, if needed.

The disadvantage of this approach is that people may receive a part of
the series, so for example can't apply it cleanly for testing. But now
that everyone has b4, fetching everything is as simple as
        
        b4 mbox <message-id>

Thanks,
Yury
