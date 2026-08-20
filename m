Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023105.outbound.protection.outlook.com [40.107.44.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B74440648;
	Thu, 20 Aug 2026 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787215810; cv=fail; b=DKJV0am6KrBEqTL406UR3x2uh90sdqfA4COQe6sWYRUNXyV40Buk7A2aAZVwq3l7KHH2y4PycAFl3lyc5JN6RuZFWRL8tn1wWNXj/56Z3cRsr6Od69zZnxB3suN3vPb7TqvVYUdLp/RAF16DFFLJLiMmNHuMDPfknJ3aQKmSLU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787215810; c=relaxed/simple;
	bh=Din/CpFTsbRWYf7eXYSkzPi/yxV6GVn9TkTOUvHCnQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NJ67BFFvzjFPidhPjTD32oq2+tZGJzBKvUic1TMJQz9uAZ14uiWSb/853LKfh6qX9PJWMqO+ussi1admc54VY3VK1uK3uoCfkmJnMQLI+JC68PB1bSb2Jt/S6TAX2YV6GPWHHLo3EX2yOYfGMkFiiBU4riBNhu9ihwjtu5zayok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=WD7clR5p; arc=fail smtp.client-ip=40.107.44.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="WD7clR5p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+r6Lx6WMJUq1buzSpMCVeQ4S8SOhwsgzRw9SdIar84cv66kwdC2Mxf6bVXjLWhL1I18mz/zNARPR58OC4N7H1YUgYfKCOqVQAWiNarGFHI1G/ujjH1tRuz4CzhsUTkc5XIeHf0uzTZnl3AM0wn4MS4EU4/m0Xmv/q5FatpLOzTY5qRIQ+6jBibtD4Eya1oTMGkcVBEYrFQTkGdOHCtxWqAxOooMnJjA+8w0D/gAm9QsSktKYsPLBpmdKMGEd2WAOog3Ys5OlDoqmAg5jYWDMhVQjyRX/drvn3NPveOlNqosVN2jq6LXUju4KCQ1Cq2zVrB/Q992SHiovOnhCj31+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZoNbFsCoL1CPyKyVPDB6xif5/x2XaQJcTHZ4K7l0Og=;
 b=stZw0z8Ah3bJPSPwE/yHTsf6onT+/mAmCeCmf5+/KzX6BAqGhzurSHlt8Q6eXeHFt3qevEJQy5hXIWmoMfbMkB/VVcXAyE6EQJ7AP+E48F+oHyWHl2xh2yQ7ww8AurEkaOmF1ox3KclzoZttJRZdstf/v4vr/oM2mNDLxk1LONYGWV17dB5XCA9PIDOw87aXOtuOhVNdfg2nsclgW9jN+sbcoN7oWdwc6N/cVxa/rekOmJdBHRsR75MoJqJxGojmccS9+d1L2WQNjcy9Newaz58LjX5ajRqUTU1NBTp1jxPds+6XfnnWbwnMgGZpePxfvVDSV1S75kJmnSwma7FoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZoNbFsCoL1CPyKyVPDB6xif5/x2XaQJcTHZ4K7l0Og=;
 b=WD7clR5pVPrp24whEYENenngUO6uawOTIFVSmRMhr2MzMpE7zzodjTp1LsA5ts1OoJ47299gVOFJaHiBvXb1o+Z2vMMX4re6Ura+zF0N4GLP2/sMp/m+KW6UaWSqfcs4spI57uqA6zw8JarpkxECq2SKDOVnjiGfxpSH/Y5haZ2A7zyYWeqxTXCuV0nEhTBrbQQApKnn332sJArUvMa4zv8avnUMxZjuLCWedrC2jkKRe+1+L3pY9sVo5Svyw4DEow6FCfxLW3gwWZYpQPezxwUX4Fw/TE4ND+xTjtHnpS1ow6fmN9kyh3Of187bP4GQg+0xGqoRd5HG/nvPs1yu4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by OSNPR03MB10326.apcprd03.prod.outlook.com (2603:1096:604:49a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 08:50:04 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 08:50:03 +0000
Message-ID: <c1d37c7c-7d85-4b53-a589-39a50ec8ad55@amlogic.com>
Date: Thu, 20 Aug 2026 16:49:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH treewide 5/5] spi: amlogic-spisg: Make sure clk_init_data
 is fully initialized
Content-Language: en-US
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Nuno Sa <nuno.sa@analog.com>, Guenter Roeck <linux@roeck-us.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Sunny Luo <sunny.luo@amlogic.com>,
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hwmon@vger.kernel.org, linux@analog.com, linux-iio@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1787165329.git.geert+renesas@glider.be>
 <9fb35ae0aedb7a6db0db6c78a8193c7602dd9d44.1787165329.git.geert+renesas@glider.be>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <9fb35ae0aedb7a6db0db6c78a8193c7602dd9d44.1787165329.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0026.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::20) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|OSNPR03MB10326:EE_
X-MS-Office365-Filtering-Correlation-Id: 409f7b8b-a043-452f-b647-08defe9806dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|921020|6133799003|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	yFW3lmUr79T7dGt4nJbXPNC3+xPc1erjSaM9nmnJJ7DXC22jKCBdUPNb23Li1be5+VhGDN/jT42wjPWi7slfHJVzwSd0MOkrZA1fAdrInxb+2pOJUN2a6IVUzB8/Aegk3Wn9m7fH6oVAOQm1jX0wmSbUzEXjF7Meu2iVYpUy+eh0hh9obfGHGHUZU4Knvt22Jpl757dITkta7Xu2gxvurTdMFP0i9I20tpQwccIxcD08iE6yn03pnKiS0rlNOgpbI5CykdvPohx2in0MdBkvIh0ewSOwRr++cqKN0wJ4N5MNxBSxlOU7UGk0D6b4pJvSQ5FY5aD47wAeIk6N6/uVQAzm08JAVJhJRIAzIDyBV7W0wgBXh2Y1G/YmUGed53XENeBgNRbjb0hJw3asuUSR5X4jLpB/rnkZeQVvzktRszw4aKK+tBQbUJY5lOkJU+KkbaMBgVrIulcVJ9OjC1zsbtw35ZqhaiNUW1w+VSPfPxzWAQK+/Syw8tlkMMEteAShEHpVg1avoNbXJcRxk9NJw14BMt2XUu3iVLdUpB1ovHxA2xYzrwGYhIMN8c1/91UGWIIG0S9XIjUVhozFYQPAK3THYj+G828OARolHBA/tH//hG0xOJLnyZ5qeIZ126vHMLJ7rnm8mGOUWP7eDj90OM4eDUgrqzfoWvY/qYYkniaRceXKUoDNOCKhQrmyAbx3lbl7pcz9PK2VNrgDzPS7lw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(921020)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHJuREl6Nng5UmRWV2FDOVV6TzVuZVBocWhBMkVaZDlRSWhiMGlZZkh3SEtZ?=
 =?utf-8?B?dkV5cEFMaGFSSTFqL1lpS3BBVG1qOHRBUEN2SG0zN1ZuV1Q2eThEREVsU3VG?=
 =?utf-8?B?b0hwWk1EZkR5bVJCOUR2cmlJUEU3d1MrSVhRVkhRd1ozMXFFVjFaUGF6Z3hH?=
 =?utf-8?B?VDBrYXRZTVpiMDIwblNKYks5cDNOdlNaQjBHOG4xNE1WRVhna214QjB3WXdE?=
 =?utf-8?B?ckpMNC9GbTFkUmIxYUZJUUgrNGtEQm9TcnBVa0owYlh1Q1pxY2tZKzZ0TzlQ?=
 =?utf-8?B?OTNNbStxYW5Na3JkUWQ5ZUg4YVFyQzhPUTlZYVU0SHlUNWdqZG82TWZ6NGFu?=
 =?utf-8?B?d1Mxb1lFOVgyYUdkTkgxR1pXK0c5Z2xIUWtVYWFaQWFaOHlUVnU5THJzSUs4?=
 =?utf-8?B?U0hMRDVQbCtKTG1yaCtFdTYyNkRQbmZGMXJOcVRKYWZhQ290Y0Y3dlZrLzZy?=
 =?utf-8?B?a3ZxK3l4ZTNNeDlYb1BES0o2Z1h5b285aytWRjZlckNQRWM1V2pUWEZDNTVF?=
 =?utf-8?B?YlVVc25IZGZTVUZkVm0wVUtCWjJOdVNPd3hlY2F6cXNielNrTmczWkJHc3Vv?=
 =?utf-8?B?QXZrc0tEMXhKK0hhTTNtQWZ4MUV3VEhlWkh3MVVTenl6c3lNSFB6L05nUWhh?=
 =?utf-8?B?UjdNNTNKVDZKdTJUdXRRdlRNNWcxOUtwSTJaQ2tjaDVsYno4SEltbEc0bHBY?=
 =?utf-8?B?WjlhbGdkSXJCVGJpNVVGZkpFU255MHQvOWwrWXpDOWl5MnZSVkV2WUFTMXYv?=
 =?utf-8?B?V0RYRnl3aW9qYWVMME9SRFN2R0ZFWVdZZis1NTRiRWxoQVhVWFgzSUhtVUpW?=
 =?utf-8?B?S2tMZmR4d3JvVDZWT21zTHNvZU9FWjN3WS9iR2NGcWJSZStuTkd2cUZFbyt0?=
 =?utf-8?B?MVgwVFFod2VDT1FOYURNY1R3RVRPZFRFZWFWbDFOUmlVYy90Z1k2SENPbEZT?=
 =?utf-8?B?MXljcGFjMWNaT0daU1MzY21UMnFHUkxVaHFjWEhuSFFJV3UzWDNqdHY4UkN3?=
 =?utf-8?B?cURrSUI2R0YrTk9sZml5Mng0ekRZV2xsTEFaUUhJK3VHUFVXWmRhS3A0Ni92?=
 =?utf-8?B?T3lHQ3FjWm9XN0l2Sm1oZmNCRHNQOFhlbGtBdFpRcHNxdDJHcmhickVwTG1E?=
 =?utf-8?B?K0x1cGFsZVRXYU5JeTdnazBFK2tsNW9ONXlSQ1pDdmpCd3p0clprV0NzR2FJ?=
 =?utf-8?B?ZU1IRC95cTRZcEQwbmhwK0R2YzZieFordjZHOHJVWUNTM1U2djgyYVBTK292?=
 =?utf-8?B?VzlvL01Ia0ZJNnFsdko4ZXFna05DekI4OW10enNZOGNUMi9iNW5GTWcvWmhh?=
 =?utf-8?B?cWR5MkM0K0pXQmFNUmt4Y01QNGUxMlptWmIrV2wvTTZMN0tFbWs4alc3RHow?=
 =?utf-8?B?RmpGTDgyVmVxUE9nUElWcHpPY0pZMDF5OEczWVB6UXBwR25YcmpPNEpmZ1ps?=
 =?utf-8?B?YWNwUHRNOFVYekhZMUh3eGdZd21lbXM3MW5xcUp1T3hSQ3ZnVTJuWjdlSGhz?=
 =?utf-8?B?TGFtRktmK3ZJZXZDZjlEa0V6bDBjQjd5SkNsTkNiYTZ5REVpa0l4alRuaXQz?=
 =?utf-8?B?ZFQ0cUZvL2RvSEFnZ2JoclJUSjRrUllvVitQR1lzL2l5OVZXWXVxZzlseXc1?=
 =?utf-8?B?aHBoMHE5UzdOUzlQWjlpUlFZdGFrQjdsSUdRWldRY21ndkFCQTE2bHV2NGJw?=
 =?utf-8?B?b3FlZWRhMko5N01EZ2dpemtORnp4ZGlJY2pmSEdqdVAwTzhrM0lyOFZYaHFW?=
 =?utf-8?B?M1FEQXV2ODdtaEhZbWlucHhjVldOWVF5Yjh1LzJNSnRyZEpLMFVmTTllZHFY?=
 =?utf-8?B?ZTdWYmJJekdTdEduTmkyUnFQdUREN2MybkREd2Z5WWk3TXlBTHpEY3RsZHQ5?=
 =?utf-8?B?N3JmZzlSajlyUENXZXU3NG1NMlE5WGZzd29pc1Vhd0ZyMVEyenRPRmw0cWhj?=
 =?utf-8?B?VGdsem1kVXZLNWhiQm11elF1NTB4VWQ5bzJUc0EwQ1JvVjd4am8vQ25YOXJl?=
 =?utf-8?B?L0pQRk9vcnRlaXFBcXdaUnc5R0RVK25MOFhBdUxVTmUvT3dmVXVrRFQ3Ym5B?=
 =?utf-8?B?U2R1alN0a3cwcFM4am9MaUh0VzhNR0JPWElwT3plMDlCTTdoMzFhTGQ1NUw2?=
 =?utf-8?B?T3dGYnpGSW5xL3BEZzNOZEswdlFpL3RGTmJaSWcyRzRmRW5aMnVhNE1mL2FX?=
 =?utf-8?B?RDNnVndUZTNRa1gvMkptMEhqYm5kLytxN2FlckRsTWdSYU9zVmxHSXk3SU9V?=
 =?utf-8?B?dVRvQlY3UWlXN0hSbXppcFdJRnFmTllTdWl3R2hIZHVuaXI0T0czV1FGMFZQ?=
 =?utf-8?B?NW5VSlBacFdQUFpYd1c0UHhLd2lUTDZjNWp6QkZ4VjlFQkZQQS9Rdz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409f7b8b-a043-452f-b647-08defe9806dc
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 08:50:03.8807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCu89xtSTHbXVtT2pvoSmzXoRLACb6hvH0j4UgZA4Pv+yXfIWMckqkoBDvfQa/97BOwdw62TmEqdw8MVnYrKgXmvJVRoZuikW29e/O9xXx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR03MB10326


Reviewed-by: Xianwei Zhao <xianwei.zhao@amlogic.com>

On 2026/8/20 03:05, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> aml_spisg_clk_init() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter in uninitialized, and
> thus may cause a crash.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: cef9991e04aed330 ("spi: Add Amlogic SPISG driver")
> Signed-off-by: Geert Uytterhoeven<geert+renesas@glider.be>
> ---
> Compile-tested only.
> ---
>   drivers/spi/spi-amlogic-spisg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
> index afc8af04638d3b6e..9049a87e9d0f2df6 100644
> --- a/drivers/spi/spi-amlogic-spisg.c
> +++ b/drivers/spi/spi-amlogic-spisg.c
> @@ -636,7 +636,7 @@ static int aml_spisg_target_abort(struct spi_controller *ctlr)
>   static int aml_spisg_clk_init(struct spisg_device *spisg, void __iomem *base)
>   {
>          struct device *dev = &spisg->pdev->dev;
> -       struct clk_init_data init;
> +       struct clk_init_data init = {};
>          struct clk_divider *div;
>          struct clk_div_table *tbl;
>          char name[32];
