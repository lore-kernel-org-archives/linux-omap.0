Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965DA36F428;
	Sat, 16 May 2026 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778911238; cv=fail; b=qPdhMwRpRUHc6YmAzkpjrKb/TcDasFXcWnK9cOWb0aMZGaJz9cmcd+1+V9Yd0wUlqv20uiBiWU6gSEWJ93/XhoCswaNoXn107En6uVO7OyxTbIcdo0Glws79bqM2uk3EJzeozCi8dRz37XUz2s1bEFHjBfWv8XqVvjLYk+4SlC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778911238; c=relaxed/simple;
	bh=hqGg82ATcMXgWIvJl26OSnKWdgEqbA1d2dhdLsYapOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Cr/humDS/TEnsDYIiFObNBOa7WLvQ4vH0jYHgNyiMOvEwFehqpc+c7U5Oun6SfWHAjcmTAzTfvKONTHbYkuhZRNk+OxpbuLTzGlIjuYPp/CwSnHXoPW5EXD+YoMeIZI8GpMXYfMJjdDshGE1K9a/GHdUOWVTQoVJga/1f+cyBkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HKps4QbF; arc=fail smtp.client-ip=40.107.208.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HKps4QbF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnB1jXgz6DF1hbrU1Y12Ait4vhfBK4lZjpVzaZd5L/0NDe3iU/5e2zwxmqB7Xo4xGkz371qvzIT762RAI+CxsZq+illESNi9CRmQBTCEvTjbvuEz3e+YaCEMugP8ylWE0hrLeWpkYvYjuEso21eOqbmTsSRxcl5mu13ZXzGgMLTqVtlPSN/8nREaSKTthf8MuDwG9nNfRlHBVOqBFGCSaenbpd9lskh6t8zGx1jdZKEFJ6zzujUVgsa86vgISB3VuE+GOc0Fd7khkpDCG4GANS6OAqt3sNabJTsiipR+px3Z2/uPwUzGnpRnu910u1g1oD+n6bWasGrGB8Lcuj7APg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0KzzQByiotypry5qOwhJmavKSNzz6Lmwq5dTYwLO1o=;
 b=ZxZTN3n9wpIprQr0kB82umc1iGQuAzPl1SasqzDzkUNm8/v8iNdnFlzlUXQNLve981gM+PRaPHxC8HzoY/GYe4iSCvpI0sMOLgXW1H5nzvMtLOskh7KnDaLug80eFJ+sMds1o/1Rza//iUC8BiKZpDOpBWgWjx7b1E+LF7EkzuL39BQzmht2RGufaQpdNkDWbE7oiRI/PE/WbCowU2lbOQbHvwjpLaGWqrJu0YCoVQRO3NxNuBNbR9uo9H9KfP2HzWeGWQ88CCmjCOWpwUADxDPatSWu0B+bzM/bDnghqYdo6PRmRfBTWx+t2zqnqfHv3aeesD1wFpBS6Fa2IxhN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0KzzQByiotypry5qOwhJmavKSNzz6Lmwq5dTYwLO1o=;
 b=HKps4QbF0JjUeCML/LxY/2DPbUScAJf7uvD9WYAqjcfcg2IZJYalZiGu5PDAlngDatawbA2/QzJzoCZrpLwkDiEvkwNZ7AvPn0FMYxsD/mAhoR8n5xm7ZMb8BwV19pVl3C21oAhaPkG632vmG1pI/ifHgZ0tTHN/Rm0L2iyBdKk=
Received: from SJ0PR03CA0242.namprd03.prod.outlook.com (2603:10b6:a03:3a0::7)
 by IA3PR10MB8733.namprd10.prod.outlook.com (2603:10b6:208:574::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.13; Sat, 16 May
 2026 06:00:33 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::a) by SJ0PR03CA0242.outlook.office365.com
 (2603:10b6:a03:3a0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.14 via Frontend Transport; Sat,
 16 May 2026 06:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sat, 16 May 2026 06:00:32 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 16 May
 2026 01:00:31 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 16 May
 2026 01:00:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Sat, 16 May 2026 01:00:30 -0500
Received: from [10.249.131.252] ([10.249.131.252])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64G60QUS1159679;
	Sat, 16 May 2026 01:00:27 -0500
Message-ID: <5961b474-245c-42b9-98df-5b0f893d1d0d@ti.com>
Date: Sat, 16 May 2026 11:30:25 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw-nuss: remove dead vid check
 in slave_add_vid()
To: Alexander Vassilevski <oss@vassilevski.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Roger Quadros <rogerq@kernel.org>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Chintan Vankar
	<c-vankar@ti.com>, <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	<s-vadapalli@ti.com>
References: <20260515225715.3641804-1-oss@vassilevski.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260515225715.3641804-1-oss@vassilevski.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|IA3PR10MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: f942e469-b996-4095-ee0c-08deb31070d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rLhRK3Zed1GCSf+CkAAwapvBadjVu66fn4Vrm1ZFmejhRO6xIiDi2hMFf/hKu0Dy2CKm4J0TPyEvi2AAnLXbmFLVZ83kmx9yJV/IUXl3uuV75d49HHpvAqp+wO4l/b0m6WE5RRlu/DaX2/8Ek9caounfZY+2rqlmfuNJAq8kL2zHTJP19rzARLVYjHVIMsWBuYfsM2+qZc1XuhOWryDsigtiYdTPeJgvF/MO4+TF1zwWJgiWbBs3gMcWUljv2pU9uTmQinhse+ZbvFXZ1ZIvLwtRNFI4++SYSY1a6JcahayJbFLMWkYNjM6cXOJNV50vUmud6x8XiAhOFhrZYtaPIJdgDiv0K5MTqkVLpksxDzkiZSArAJBC4bFCb7UK7iXM1OGHnohdU8kdWQiGxSfJPLQM8pUZGozTU+4CVt0IvqEyP5OC5bbPA4iD88dHXZTjutJpMWbtU5YfuK38mfeT3TOTVZrs6qdMDZCbUtEincTC5JWhJQxsXOa9Zu6aEjyvkgniCpSILzTY6rtrkDtAXw1Z0w6HBaANUQO82LUcz9Q99gU7Cd3rb86V+JuSFVJTJ4TtTg+ZhUTYowH0FOeTQzpj7OSojZ1frX5zY4EEbf4uqaoF02AOspYBM7aZcW6Uf1LPxFVf6fiTuSHlGrdzOYY46ZAtmKSHUvAUKqny4mkahVy3VslNuhsE6NfBx4zwDMQ7JzRE5IkWJii6bB3ZVb85YdT/rNYVSKiIM8R5QhQ=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X4PP1we1/23Lumt/6XOfdVasd9kSs8RNpGpdoyZq2IKtddt/Gt7lqj3Ne84bX8VAB32KLen61hbGwJNTS/PsDtokyxnBufRXHoEV0st6J+N22zg4xAg9SxTf7HxqQ5DFbSK7awQ0c4+XofQtCD2gh30PrLGADkgwdrNQ7Eg6owqMlRYt1echmLFdSlvoTApiUldfhbqc1WdhcxmUv/GSWLUZ+ZvoXk41eM0oKnCr9lFIHPL9hKrw9gvx5SYhcXkhSQtF8NTrC1J1tTqCRjbgTbI4NfLOzL7M93YGor94iHbrJ1Nm2t4zZqDkzLNzhzwAhwd+8vY8wWS9gyKuzpH3kgXF/7ZOTvG02B6yRi79bmIw9zfbouAC33KDJb2Kda92LMM6uS6BL8n/+R7uwOKVNR4+ODdGEwa9VINzuuVitNyK0WNvM3o8+5zfkctWaTar
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 06:00:32.5412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f942e469-b996-4095-ee0c-08deb31070d0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8733

On 16/05/26 4:27 AM, Alexander Vassilevski wrote:
> am65_cpsw_nuss_ndo_slave_add_vid() returns early at the top with:
> 
>      if (!netif_running(ndev) || !vid)
>          return 0;
> 
> so vid is guaranteed to be non-zero in the rest of the function. The
> subsequent
> 
>      if (!vid)
>          unreg_mcast = port_mask;
> 
> is therefore unreachable. unreg_mcast stays at its initialized value of
> zero and is passed as the unreg_mcast argument to
> cpsw_ale_vlan_add_modify().
> 
> Drop the dead branch. No functional change.
> 
> Found by Smatch.
> 
> Fixes: 7bcffde02152 ("net: ethernet: ti: am65-cpsw-nuss: restore vlan configuration while down/up")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/kernel-janitors/aS_lhMwppbDHoEcX@stanley.mountain/
> Signed-off-by: Alexander Vassilevski <oss@vassilevski.com>


Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>


> ---
>   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 7ac75fc8cd..77f59996a0 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -316,8 +316,6 @@ static int am65_cpsw_nuss_ndo_slave_add_vid(struct net_device *ndev,
>   		return ret;
>   
>   	port_mask = BIT(port->port_id) | ALE_PORT_HOST;
> -	if (!vid)
> -		unreg_mcast = port_mask;
>   	dev_info(common->dev, "Adding vlan %d to vlan filter\n", vid);
>   	ret = cpsw_ale_vlan_add_modify(common->ale, vid, port_mask,
>   				       unreg_mcast, port_mask, 0);

