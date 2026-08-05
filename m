Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B072110E;
	Wed,  5 Aug 2026 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891686; cv=fail; b=NrxHNe+u8p0EnL08v3yZ2Wbsi6vxTTDWD8qRuLL1FAXcyA80iqDiDtsalPfFwDex2V/NzZQVs3aOOdydsM/bskjVVoEuOlC5CdupxKNlUYg1QFjcFqKGaFmgmDs3v1e6LL+qrP2DwZmRqtxCvrdgfDOanhln4n4LNBR1mFXbta8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891686; c=relaxed/simple;
	bh=EIV+0XBmf+Lm8z/T7m6nC8UQiIhc3SrT2ZbtWZ/SO2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T+o+WyRjDDIcWYHQXUqZQnn78l5nVwiC2tmVFWlvoBsp1aMQ9dq8pAk9kVy+Qi8PughADzOmlBp1c4EstW3zO6Bc3XnRD3xYNOqPbmnBXKtOySjpI0/8EzpiHD7Ysrz/CA1fIMLQXXJUqluTzhyHrZVaYCfKJITL8j8K6/I+wsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=YupV8+Lj; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MfL7ybd6; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DtsvWKci reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YupV8+Lj";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MfL7ybd6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DtsvWKci"
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674NIbsm1250693;
	Tue, 4 Aug 2026 18:01:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=EIV+0XBmf+Lm8z/T7m6nC8UQiIhc3SrT2ZbtWZ/SO2I=; b=
	YupV8+LjpC3VGXB7kPfh5JZN45WoR/sHntTdayVIs3XmHwyxoVICA62VzveOdhcy
	H9lwgkcp0SZwWoyHAOWuOxpxX6nZmPtQXOL6CmeRj1BUAMhsLD5Eu+bl1IOcFxd7
	TLoagnnCpeKZQxXdVkoe3yxnTMqQ1taEUQrPl39pDK80s8Rass5cMm7grWetqJgU
	KFJtN5Cswa7soi//2vO0xtlunU6oDW1qW1yw4hv29iosdFnPyj9G0FsS433WtNDE
	1upGRVCKCmbEHWXNNVGkz0+qUYY6avjUJYRA10kbSnuYbaUUGwozFD1LlLdXIEwZ
	vhpN5LAU54UuaeyeYcnPcw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4fufyjejbg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1785891670; bh=EIV+0XBmf+Lm8z/T7m6nC8UQiIhc3SrT2ZbtWZ/SO2I=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=MfL7ybd6KqL76DZkVoDCGq14RfF7BpCuBu/N8IjjvqraNdcz45YIWToeo8JhM9an+
	 HK7q7MwvnUqpCnPxRQ/3E7CTiQNvLyHyItOLxAAqAS6reOYO+CS5uRWTrSZsfVwIEA
	 XCluhlBFmaSVFySF7WgQ0OvJs0z5T/SPUr5Qyd5K6iYXpGy93Vjc8lsr7rtmPt3f5k
	 4vNK0R4Uxim5Y1vjt0BaHAZ0MbXgMPkM05mzKZR+pp0Nn8aBlzvUrazFsVSO1rPI9W
	 116oU+5urNQ8NNblA17zc6yG6B9FercJQ5sUz6etgipi2nKV3DyTJlSNTLEgRjr/g7
	 QKzuInikxvJYg==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F3943403AE;
	Wed,  5 Aug 2026 01:01:08 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 7E6C6A01D8;
	Wed,  5 Aug 2026 01:01:08 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=DtsvWKci;
	dkim-atps=neutral
Received: from CO1PR07CU001.outbound.protection.outlook.com (mail-co1pr07cu00105.outbound.protection.outlook.com [40.93.10.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 636574011C;
	Wed,  5 Aug 2026 01:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRpnAyjK+4L9JW6rrDkkZ4kCArlgyx1EvxvF5G6hnKXEqGUqoxozLt2FHNC72qbP5mPy0kzhylChk6LvRckEeTDz7xW/a4/Yt/aqSwkJ91Tt0agIUmA11tfa5/M8U3+baLfeoT94s45XvJIFjMeyn8rzS/gnqm//UlhSK3iP4oHyOhugbsuhC4LgUsixZsJsggcKdPRG+KVVs82bUSrkRWlzjRYyuLSGG8qZG5RTBli2mxZnWkWMcIbcWwmuHSxdSxGppP1nPl3YRwiQ88YgRqZz+DqvzeUo4znwn5AkP1/xijb3QR4HoJ4K5egEyYraw/TmS6TiHB+TrtVqskuWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIV+0XBmf+Lm8z/T7m6nC8UQiIhc3SrT2ZbtWZ/SO2I=;
 b=KGn/D7jWLo9pd5SgLO3JHz7on2CLhZt62IWha+cJFYbwQOAQ6G4iSiAKlqqe8uzrGsOudqGoBA7cnCJMnrLL1kN5/fbhhAWXbM6c2QWUQFrRZ5CyVBeb5j8GV46ACxWVWNpE4kjGvcjbnpLvps/Cizp373Pvyks68FU7dY0pHAj9OLlf5oXAK2T6EObchP7K//LPFt7fqtW9IhyFR5NkL9xz5UU/+fAgXvKpYcntp9vJuJ4T0Fd2wEUv9Bmv+iEEQGvNCY1rk4eptjCjoKJvVpsONtgVJUzhAndEF05TbWYjBXgG4jDW/jO1IFwfO+/QH1yZMmvl8HyZDounkupriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIV+0XBmf+Lm8z/T7m6nC8UQiIhc3SrT2ZbtWZ/SO2I=;
 b=DtsvWKciF+yXjf2+K4jSciIlfPUS4upe2BpUH1lseA0Z0CPgeIBrWVXIB+RIQcZPfzmRksURfRxvj12Ah21FO8TJWlZClm7WM9MrrBdV3oXRJOOgl3BTSqtFLMQJiEmkWZ4AqvlFGRgFc5pIOtE/EEabJkgpBip+hWqEj2suX3w=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 01:00:57 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 01:00:57 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Pan Chuang <panchuang@vivo.com>
CC: Peter Griffin <peter.griffin@linaro.org>,
        =?utf-8?B?QW5kcsOpIERyYXN6aWs=?= <andre.draszik@linaro.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "moderated list:GOOGLE TENSOR SoC  SUPPORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:GOOGLE TENSOR SoC  SUPPORT" <linux-samsung-soc@vger.kernel.org>,
        "open list:DESIGNWARE USB3 DRD  IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/FREESCALE IMX / MXC ARM  ARCHITECTURE" <imx@lists.linux.dev>,
        "open list:OMAP USB SUPPORT" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 04/11] usb: dwc3: Remove redundant
 dev_err()/dev_err_probe()
Thread-Topic: [PATCH 04/11] usb: dwc3: Remove redundant
 dev_err()/dev_err_probe()
Thread-Index: AQHdIKBvoR52peS3QE6DAKt8NlvmGbaOqnwA
Date: Wed, 5 Aug 2026 01:00:57 +0000
Message-ID: <anKLOTXxaT0on1YZ@vbox>
References: <20260731035448.252289-1-panchuang@vivo.com>
 <20260731035448.252289-5-panchuang@vivo.com>
In-Reply-To: <20260731035448.252289-5-panchuang@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|CH2PR12MB4197:EE_
x-ms-office365-filtering-correlation-id: 6c3267ef-ad34-497c-3c6d-08def28d0246
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|6133799003|10067099003|11063799006|56012099006|5023799004|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 uy3jl7zDR3Hds5EsfJF/bclnQgFiN6tVo9pMe5hePbuZakoVqD/mdsxt5/DVY2VaCw5vyEvcew5yXnL39EUTIXIGwoPLKWBdlPLcxVoh08isFXMeG0Eq8DZrjfTQA99Ijky3mzrME6lLSBiYyWreJTWKAxs409JLU84h7lWzdkqZ011M9vFbLmzkrs4ChY0ZmGHhzq9bWeNmgI7xKxy379UmX5qGudjRF4mEVFZXDMKknbsZU1GwudXLUVyCghJ045VvznckLrsJHjLoAPedHIPbwagrn9r4dKy68R+2iQQv8EkykKwWRq4ukdQCVR+QYXv1JoJgwgqQDfAX9eFKp7lNEUWjMhJFTojwWiegzRpJtYGxoJN9O8GzicPWIFkFQ0uOrr5L5QhIOsUMBdhcv19jQDCfw1DvbIzsPu665OKHeovfVpiv4IwPxafwyKU2P3uL99BQ1XNLefGuwheLxKvhii/hlPhQmoibfWF+Pg6SNDqAl/pDm1F7x98GZu2gsYMlIdcYGGYSLO3NUjkLiXQNI7tjuFKLY7NZi3LnnO2h1zn6hGvrCASuxTO+ZzmP0AnBRdy+LSas5wQa9J0GoOlo6Qzt1XZ+5LEg9//VzNqi/JlcX3tWP+N7S4emxFlcwbO8CgntwXKP9aai6uFQIwTZ3QgSyBX88jcm3e2WbymgEMsBNCcd/5ZRyDnvh6ceNmunFtQL7etGhfKffBDdOPhE6UrOYB0VZx8WsPdkzeA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(11063799006)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWt1MWZFYmVOMGdKOE9DUnljazFxTk1CQkFFd205ZkJYcUNhRU5taGYwZmNP?=
 =?utf-8?B?NjdseW1tMk93UXk4SzBWUzJBOERLY1k2WnJ3K3pGQjJwNmNadWVicU9vZGpH?=
 =?utf-8?B?SXJaLy8zeElLN2pOcDl3d3pzK0RqdjlDYmJnSGJON29WRDJWaER3aUJkcEhu?=
 =?utf-8?B?U3NvMEltY0FCMzBhanJQcTFkSUpQdm9OZG1KTGlBeEpHZmtrbm81aE1sR1Fm?=
 =?utf-8?B?TTA2Vi9OUE5QTUFFRnovRitGUnZFNllGVkI1QU0zTmhPNXZrc2JGWUFOWFN6?=
 =?utf-8?B?UTU3VG1wRWVyZHVVUDBHM1d2RmwwMnlGeTFvYm1qeEJ3Tldnem5QUFIzRGNo?=
 =?utf-8?B?VnpqTHNjVGVkYnhGNGhSMldHcjdWVjgxSnN2WFJ1TzBtQWM2aDQ3MFhBc3VY?=
 =?utf-8?B?anNaZVFzdVhKZkdya3pVYnBFdC9VZEpUdkNnZW5EN2VEVjNKRkg0Si9oVXZP?=
 =?utf-8?B?dEZBb0M1TzNRU2xlZGlhOHIreXRGQXMvTEF3S08veVJCUmRWL2dRNjB0UFgw?=
 =?utf-8?B?RjFFL09xQUtvQU5rNFJtTWdleUllK3VwL3B5aExpWTJnQ0FmSFFwRlJOZE5v?=
 =?utf-8?B?Y0gzajJrMzZubXRIM1FVcW9KdTRPTUJ6M1JORTNGREw0cHVuUW9qTkVnU3JP?=
 =?utf-8?B?dnZoRzNTYUJOZWpxNHMvS0dwZzRUTUpHRldqQ1lIL0NxVSsxY0I4ZE1qMTRw?=
 =?utf-8?B?TmM2aGFEZHNIYmhMejMzK2R2T3MwMHBJMnNFdnV0R2NGU0JpckxPSzk1Z1F0?=
 =?utf-8?B?N215RjNFRjhFZW1lQU51WGpqVlJmWVZXeFBUVFRHOE9vUWFBb2NmTktVQTJi?=
 =?utf-8?B?QUcyaGFkV3A0dis1R0hIU2xNa3hNcEpPdWNNT2Y3bC85RGV4RC81ejFGL2dO?=
 =?utf-8?B?MGgybmk4aTVER0Q0ZGZRSTRoUGE4ZTVxeS84Mk1nR1BZakdHUGlkY1JmdytX?=
 =?utf-8?B?S2ZxZ1BXTTJKV2loZTloS2JucmJ4UHZ3OUpBYkNXSGc2M21BSWFESGhpZ01o?=
 =?utf-8?B?VERNUndkcDM4WnlaYXBxSVo1OVgzdmN4TzNINjgrODBUWUJrM3NTdHlydDhZ?=
 =?utf-8?B?dWNRVVd3Y2ZsUmE5WGpPcWlVQjduSnlEelhWL0dlWTNWMGVMZDJ6SlE0VHhv?=
 =?utf-8?B?T0l5eHRXc1N5QytHbDFvdXJTa1RsUUFyWlJSamIzcTBjR0F1emhvSzhCZCtG?=
 =?utf-8?B?c214QVZUUVlsUllCVS9iaXRaN0FUS1hyUWlwVkhCK1ljalRiMjcxOGhLQ1F2?=
 =?utf-8?B?RVVENTR5bXpwTERtNW1KMW5aNjNPWkhrc0lucXpVcXNXWlMrc2NpNEYzWi8z?=
 =?utf-8?B?bVNub0gzWnBWSmdlcXlEOWpOclhKWnhYSStJNXpKSStEUWduWnVhYlB2MUZr?=
 =?utf-8?B?bDg2OVVQcUtJOTNPL1YyMVVTdElYbDhEd200Vm1DVnZGbDdvM0I5OFNDKzh3?=
 =?utf-8?B?MEZqNEFPZVM1MHFNNVduOU1pbjNTNkt6cVI4Rm40d2ZHZHJSTUFqd2JadmJB?=
 =?utf-8?B?WDhnV2VlMG9LdGlOT2QrVE1HcXV4NmFzWE1XZzE2SVcvclh6bmVrWW5LYXdR?=
 =?utf-8?B?TXFEVzhUUmRGMmFNMmpRTWxTbEk2aVJ0SU5FWktkSk8rL0hSQlBxaUJiSVBG?=
 =?utf-8?B?NmJqTEFVSHh4SE04VEpWMEJvckJrbERSRHd2ZVdaR1E5YWVzMUdTQkJndFJx?=
 =?utf-8?B?OXVOYjZOMS9KRWpSOXN2NlNXNlNsa3lCaEN2U0ExZVlSWVpkZjhyb3Qxc2VL?=
 =?utf-8?B?d2dtcEJ3bE5sNkVIUzNrMmxscWJCSFNHZlNnZUJ3WWlpZGxtWkxtcm1aVTB5?=
 =?utf-8?B?MjZ1dm52cUxFYWozZzNEOHJzaXhySzB1bzNXUHhLQUJxNzdNREROcXlQK2JT?=
 =?utf-8?B?eWlqUlJ5TzJXQVdsb2MrNENDL3BzUEI4Y1VaZnBrdjZyNlluUEF0bVJKd0x4?=
 =?utf-8?B?RjJ2cytsaERDM1N3TjVtcGlWa1JMS3dxT1lSM0ozRDd2NFZ1UkZwczBYbkxI?=
 =?utf-8?B?V21mTExKdUZRZzNxbGhRUVh3NjJpcklKN0ttaWdqVHJXYS9lSnFpSE43L2lB?=
 =?utf-8?B?NmYwRUhXZmIvbnVKUlNxV29raitHb0xCRDJ6SVV1YjAxVkJmTE94MkxxRTdj?=
 =?utf-8?B?TnZlZUQ0MmlVRTZPQ1BIM1BjcHZyeWlnaW9BM1RZRU9HeDhYRytrWmlQeit6?=
 =?utf-8?B?YllqbTFkTDc3UVRtRWxYYTIydkFjdTkzQjVIdWd4eDZwS2F1N2gvcEUxT1Bi?=
 =?utf-8?B?NmhpY1I1MzV1NWJIOWpBc1hlaTg2c3RoM1pEL2x6cGtoWnk2eDgrdWRhNTda?=
 =?utf-8?B?N0RSbUZCQi9pOTJrRmsrWkhjQ2tSZXI1aHJ4SDFXS2E4eWJlL2dBZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3508C0B1AA9C448B1CED205A2E230A9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Jv3/UYmGVU6LS3F448NQkxmcwXjNy0bTKHjjs5lxDOEAxioRmwS9TliJmK4d+oLpG/mRSSfNGqW1nfg9ZCKRb4IU/jBhsV/uci4JhEG680ve/nzuvWtLZPs4RQ+i0ROY8FlEH9kFiwJQyPXghBh0+a6NlC4iQjFIbK6xIL5RwYBb+6tTSNZnwDUJQLCOiW1MCh2oO/qH3qQeqecuCaeKhRwY156hKDgtBxZ6nfoQpqoE93A69Q442mvzYobEDz//8gT8AJBeTdn7nX0Ry0wfhBkGIc4EO+dKGIhgovzXRmxInlsMZNC3MSrQFa9cLxQN78ulZMZ4yu9M0ofF6Jjysg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G8gpw/eAAv0dgIARyLu72ASqdi+g1dSrVsQiUS7n7dLH+kQLJNpOfIZdPdWqPat2qNrWyQbWQYVyGF6yVWLPaupmHn0beOM3u0K74F6XJYYuhPeGZ7h1c5VhJvyUmLXIcCNtgYsZB3rv9Cmnl6EN25KhKNKo2GrELnIuBtZ3dhl97l5W6onqo6zrz12bnd/m+ZBBCYUPS0HJMn7srrwomu5bmDrZ83YtmeCbG9AgIaWHxF3GSihNHWQ9HTpYNgxlfoE4AsVoGG9QPjCzCZGULjgpDZ7U83/LwiN8ZcEfDgk2Wkn8QWoM+65HPFv79RJ749/4tyAUcg+94fDxi+yYaoCah6INgsohEX4HzFZ9KXC0bMBuE/t6LOAyRAekEeifFV2I+luFKf3BzLZ7OV/P4u1cruRmkAwzsGdE7mWbeuPfY93RGH7IOufXuUzJVi/ngTtLQhOyECxC3glZTLbzU4mwsEfNj9oHVJicL2Lz5cBpzMLTTEgtBWCuysHKVMyJ20DV8Ox4Bpxjng3NiKhNQo3zamk/aGcWCp1E72MXw2V5jaOmNYfKlH2b2CxaKEmeDiu/RRG8TRUsqT7crQ0kf5N95BIQmfmr5GRNMYtAD76r3pe+1vgCBJGbyZqLKk8p2xgaGeVcX6oCILE5Qz+tZw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3267ef-ad34-497c-3c6d-08def28d0246
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 01:00:57.5304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +zf9r9IyIHQb4h6vnLbFefwC2AixM1Yt11nC08UNj2F6FWMYB/49O6Eh77Ya71JbmMkom+Qf51tWVK04cqY7Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDAwNSBTYWx0ZWRfX9nAKisHsksME
 eSvUbnPH+zrrzRAsTBWyaC4eUsnytjdp/nipMMDnQ7T0O155NjwboNS0AVDk3FOvpil4gGNM4iz
 LK13O/NaIvaAtpgw+7Wh09CxVFmwicU=
X-Proofpoint-GUID: uk-P2waJH2qVGb0HfQR7pZUS8MA_8tSi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDAwNSBTYWx0ZWRfXzolzhmKwitv0
 bNAaUJLw3Ot+J9EUNwFmd9yYbw2Ijj0i3yb0I07GwUhSUqlvQ/o7uuzRH6D0zOHAIxreg4vzEO9
 X2maTyciuYt4YyW23kpIWOrNKwo7RJbg8qQxtcmmo2VVjgKTZ5TqyvacmFBC8Hjgua23ty+gLQ4
 2o6t2IjfWdhaf/nO6I6H7F/HGCQ/N3+RgJtP3I2qvG/5Q9ReqJZt9ZNsMlcwVenzjRCbFbGzbGO
 9RRo4Fn9yLLUpD83ip5upwGmreoDxlpdxEnKuqgiwBL/kiFqTp6cz3cD9yQzvkVFNUbKUUHR6t2
 O9Pu3GJ83M7ZadJeApZ6uqGLc6Xn5lZI+6GLIjpOpuvdut1ejRLjtcrSnCLWP+E/cZkFfnzAFpf
 EqoKGBvityjOvrY0NfdQGHluaC4ZuHVXCFa04I3Z05R+qmlIhi4+PoUYD2CF9/pfWTTpyjISH8c
 g8pk3MpPawQKiXTVmvA==
X-Authority-Analysis: v=2.4 cv=CaU4Irrl c=1 sm=1 tr=0 ts=6a728b56 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=xKlp24NoqlmsZ8y70KjX:22
 a=1WtWmnkvAAAA:8 a=jIQo8A4GAAAA:8 a=xq3uGEXYuZnwxNl_GPEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uk-P2waJH2qVGb0HfQR7pZUS8MA_8tSi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_06,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2608050005

T24gRnJpLCBKdWwgMzEsIDIwMjYsIFBhbiBDaHVhbmcgd3JvdGU6DQo+IFNpbmNlIGNvbW1pdCA1
NWI0OGUyM2Y1YzQgKCJnZW5pcnEvZGV2cmVzOiBBZGQgZXJyb3IgaGFuZGxpbmcgaW4NCj4gZGV2
bV9yZXF1ZXN0XypfaXJxKCkiKSwNCj4gZGV2bV9yZXF1ZXN0X2lycSgpIGFuZCBkZXZtX3JlcXVl
c3RfdGhyZWFkZWRfaXJxKCkgYXV0b21hdGljYWxseSBsb2cNCj4gZGV0YWlsZWQgZXJyb3IgbWVz
c2FnZXMgb24gZmFpbHVyZS4gUmVtb3ZlIHRoZSBub3ctcmVkdW5kYW50DQo+IGRyaXZlci1zcGVj
aWZpYyBkZXZfZXJyKCkgYW5kIGRldl9lcnJfcHJvYmUoKSBjYWxscy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFBhbiBDaHVhbmcgPHBhbmNodWFuZ0B2aXZvLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L3VzYi9kd2MzL2R3YzMtZ29vZ2xlLmMgICB8IDQgKy0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9k
d2MzLWlteC5jICAgICAgfCAyICstDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtaW14OG1wLmMg
ICB8IDQgKy0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLWtleXN0b25lLmMgfCA1ICstLS0t
DQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtb21hcC5jICAgICB8IDUgKy0tLS0NCj4gIDUgZmls
ZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ29vZ2xlLmMgYi9kcml2ZXJzL3VzYi9kd2Mz
L2R3YzMtZ29vZ2xlLmMNCj4gaW5kZXggNjBlZTRjYzk5YjI4Li5lNTgxZDQwN2I4NzIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1nb29nbGUuYw0KPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MzL2R3YzMtZ29vZ2xlLmMNCj4gQEAgLTIzNSwxMCArMjM1LDggQEAgc3RhdGljIGlu
dCBkd2MzX2dvb2dsZV9yZXF1ZXN0X2lycShzdHJ1Y3QgZHdjM19nb29nbGUgKmdvb2dsZSwgc3Ry
dWN0IHBsYXRmb3JtX2QNCj4gIAkJCQkJZHdjM19nb29nbGVfcmVzdW1lX2lycSwNCj4gIAkJCQkJ
SVJRRl9UUklHR0VSX0hJR0ggfCBJUlFGX09ORVNIT1QsDQo+ICAJCQkJCXJlcV9uYW1lLCBnb29n
bGUpOw0KPiAtCWlmIChyZXQgPCAwKSB7DQo+IC0JCWRldl9lcnIoZ29vZ2xlLT5kZXYsICJmYWls
ZWQgdG8gcmVxdWVzdCBpcnEgJXNcbiIsIHJlcV9uYW1lKTsNCj4gKwlpZiAocmV0IDwgMCkNCj4g
IAkJcmV0dXJuIHJldDsNCj4gLQl9DQo+ICANCj4gIAlyZXR1cm4gaXJxOw0KPiAgfQ0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWlteC5jIGIvZHJpdmVycy91c2IvZHdjMy9k
d2MzLWlteC5jDQo+IGluZGV4IDk3M2E0ODZiNTQ0ZC4uZDk2N2FjZDQzZDQ0IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtaW14LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9kd2MzLWlteC5jDQo+IEBAIC0yNTAsNyArMjUwLDcgQEAgc3RhdGljIGludCBkd2MzX2lteF9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQkJCQlJUlFGX09ORVNIT1Qg
fCBJUlFGX05PX0FVVE9FTiwNCj4gIAkJCQkJaXJxX25hbWUsIGR3Y19pbXgpOw0KPiAgCWlmIChy
ZXQpDQo+IC0JCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIHJlcXVl
c3QgSVJRICMlZFxuIiwgaXJxKTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gIA0KPiAgCXJldCA9IGRl
dmljZV9hZGRfc29mdHdhcmVfbm9kZShkZXYsICZkd2MzX2lteF9zd25vZGUpOw0KPiAgCWlmIChy
ZXQpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtaW14OG1wLmMgYi9kcml2
ZXJzL3VzYi9kd2MzL2R3YzMtaW14OG1wLmMNCj4gaW5kZXggMWNmOTY1NDBiNjZlLi5lZTkyYTVl
ZmFhNmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1pbXg4bXAuYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtaW14OG1wLmMNCj4gQEAgLTI3MywxMCArMjczLDgg
QEAgc3RhdGljIGludCBkd2MzX2lteDhtcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiAgDQo+ICAJZXJyID0gZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycShkZXYsIGlycSwg
TlVMTCwgZHdjM19pbXg4bXBfaW50ZXJydXB0LA0KPiAgCQkJCQlJUlFGX09ORVNIT1QsIGRldl9u
YW1lKGRldiksIGR3YzNfaW14KTsNCj4gLQlpZiAoZXJyKSB7DQo+IC0JCWRldl9lcnIoZGV2LCAi
ZmFpbGVkIHRvIHJlcXVlc3QgSVJRICMlZCAtLT4gJWRcbiIsIGlycSwgZXJyKTsNCj4gKwlpZiAo
ZXJyKQ0KPiAgCQlnb3RvIHB1dF9kd2MzOw0KPiAtCX0NCj4gIA0KPiAgCWRldmljZV9zZXRfd2Fr
ZXVwX2NhcGFibGUoZGV2LCB0cnVlKTsNCj4gIAlwbV9ydW50aW1lX3B1dChkZXYpOw0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWtleXN0b25lLmMgYi9kcml2ZXJzL3VzYi9k
d2MzL2R3YzMta2V5c3RvbmUuYw0KPiBpbmRleCA3ZWUxNjEwMTYyYjkuLjhhZDMwMmFiZTg4MyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWtleXN0b25lLmMNCj4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9kd2MzLWtleXN0b25lLmMNCj4gQEAgLTE0NCwxMSArMTQ0LDggQEAg
c3RhdGljIGludCBrZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
DQo+ICAJZXJyb3IgPSBkZXZtX3JlcXVlc3RfaXJxKGRldiwgaXJxLCBkd2MzX2tleXN0b25lX2lu
dGVycnVwdCwgSVJRRl9TSEFSRUQsDQo+ICAJCQlkZXZfbmFtZShkZXYpLCBrZHdjKTsNCj4gLQlp
ZiAoZXJyb3IpIHsNCj4gLQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gcmVxdWVzdCBJUlEgIyVk
IC0tPiAlZFxuIiwNCj4gLQkJCQlpcnEsIGVycm9yKTsNCj4gKwlpZiAoZXJyb3IpDQo+ICAJCWdv
dG8gZXJyX2lycTsNCj4gLQl9DQo+ICANCj4gIAlrZHdjM19lbmFibGVfaXJxcyhrZHdjKTsNCj4g
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLW9tYXAuYyBiL2RyaXZlcnMv
dXNiL2R3YzMvZHdjMy1vbWFwLmMNCj4gaW5kZXggZmU3NGQxMWJiNjI5Li4zYmZmNzc1ZmJlNGUg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1vbWFwLmMNCj4gKysrIGIvZHJp
dmVycy91c2IvZHdjMy9kd2MzLW9tYXAuYw0KPiBAQCAtNTE4LDExICs1MTgsOCBAQCBzdGF0aWMg
aW50IGR3YzNfb21hcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXJl
dCA9IGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEoZGV2LCBvbWFwLT5pcnEsIGR3YzNfb21hcF9p
bnRlcnJ1cHQsDQo+ICAJCQkJCWR3YzNfb21hcF9pbnRlcnJ1cHRfdGhyZWFkLCBJUlFGX1NIQVJF
RCwNCj4gIAkJCQkJImR3YzMtb21hcCIsIG9tYXApOw0KPiAtCWlmIChyZXQpIHsNCj4gLQkJZGV2
X2VycihkZXYsICJmYWlsZWQgdG8gcmVxdWVzdCBJUlEgIyVkIC0tPiAlZFxuIiwNCj4gLQkJCW9t
YXAtPmlycSwgcmV0KTsNCj4gKwlpZiAocmV0KQ0KPiAgCQlnb3RvIGVycjI7DQo+IC0JfQ0KPiAg
CWR3YzNfb21hcF9lbmFibGVfaXJxcyhvbWFwKTsNCj4gIAlyZXR1cm4gMDsNCj4gIA0KPiAtLSAN
Cj4gMi4zNC4xDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lu
b3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==
