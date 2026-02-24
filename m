Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5B24C692;
	Tue, 24 Feb 2026 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923651; cv=pass; b=aVmpihBIMkaiREnIVa9Wnv6mV9OlSTmsVj2at1uVcN4UvbDd7fYfevZWUGd5HkC3LV1VpZxstSLfgcrRHLrZ4f+uUkRZW4uhPfx4ftVUrXi+YIF0FUqhPREtXctH9iKexBJy0CmI3pO2vULzd3E+lmPJL+7yezWC9TMMiwuo2+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923651; c=relaxed/simple;
	bh=KT066q5xWJRud5NE33MICsEIixK1+hWqdcUsGN8Sm2U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ckaf6snhwtJOu//mCTO8HKnNOx+1JPBgpr9vDihBy8Ui60eeoFEM58/shEXn2EKaP7a7H2aXrSr3vZp8nScb9azaBvwZgcu8E8Etq2M1CcUolwwbNPcfFs5/njlCh9o80S4l2yA5LN64p/BAcQdwnwZgVJruHyUhBNXDzI+meT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=gdrt9Wk8; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=KbuykeOt; arc=pass smtp.client-ip=81.169.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="gdrt9Wk8";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="KbuykeOt"
ARC-Seal: i=1; a=rsa-sha256; t=1771922921; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nB4zpHckCKF+jvQUIH2KbU++0kkby2JO+eouCgWYw/Lp6V0WyY04utvaXvw74gNta9
    RyGbza9+kj8+m9hLU6yuCqG1e6HepWGavWcQTqHERHc8sTP3CBI+PCSVsXIdzufLqw2R
    Wy0PHwIyiPcV+0mxJUJDaTn8pUFI/gR/mcng6qkWQxGcHmr6ulyfloohugmI7FKoFy5g
    uRIoif5l9Fj6PmjbZww1qZmN19Wyz71W6dMYgRnZKlbbxWKiIbaUXuhRD7cZRswdz1KL
    qbhDh76ByI3O4B62osp+Nruhm/4mwRcg1BOZoT3CUDNgQvvwT95DP8REi/Rcpaiw/MCZ
    2hRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1771922921;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=KT066q5xWJRud5NE33MICsEIixK1+hWqdcUsGN8Sm2U=;
    b=XQEXUYd6cOSg9volYbkjoRhSArPLQwdO+3u5qRXGXTwABCX/S7MTmkrUgP012fkXrV
    lVMqYfdoVBdTI9HPADLk2xrSBzD7WUBgwK+YBS+JymBp0aNUh+HPfdFY4Fq1tz2IeqyY
    wFVfPT7v8QEOUQoykLos8qghxhPUzYYhgVgvgLrz+mfHiOebmWqIyxONTSraaQIfsZbH
    WyPfl21MQf4BjwuF+q08th9ObNkmodwX5v6QvWoASuqUqYR4nHLSy2bIfzxy+PpY3Rhx
    XLhfTAXEg8xQ2yIT7xKGZ1kG5QdOa8t++z76hvt5OBSVZrDbBF7tS8OWDk9WVAR3KOSl
    dX9g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1771922921;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=KT066q5xWJRud5NE33MICsEIixK1+hWqdcUsGN8Sm2U=;
    b=gdrt9Wk8i8jy/pHO/nqFVkQ80z57DZzB4fa8eXRMvGm1aJ6Tfv3vfa3QgqmvOI5dkm
    zEJXby/H2g1Xta+6sy2TrjZj7dxEuWhyAIvLs3WZA1vIPopqyEzt0GmP4geA9WHVNmRt
    nArwpwTNIKpnzU+9EaBgJog0LGRfkTEMlL6clisGGJMWpDce2od7YIFw6/Y/k7jQlEhF
    MM2OQQ2HQut0dJOCcuM1NvPjnjpVmCNVY1f6xjxxta+P24BYEvG4cOkxGmEQig64kJl7
    ySRHOTqFrjw8447MQ+pFLITm18rwMLaPSLuL6vrPv6VMHXmg6XA/9SEiv3E7SQoI9MXn
    1Qyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1771922921;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=KT066q5xWJRud5NE33MICsEIixK1+hWqdcUsGN8Sm2U=;
    b=KbuykeOt2fsEPrtUrX7B2OzjM2SgwS91oCkzZHCFXMk7RApbxm/sMK6U5MZr1qK7Cv
    1kkPEUZBwG/Gai3sGmAw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeT0Z"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.0.1 DYNA|AUTH)
    with ESMTPSA id Q3a36b21O8mdY1h
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 24 Feb 2026 09:48:39 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v4 2/2] arm: dts: ti: Adds support for AM335x and AM437x
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20260105162546.1809714-3-parvathi@couthit.com>
Date: Tue, 24 Feb 2026 09:48:29 +0100
Cc: nm@ti.com,
 vigneshr@ti.com,
 afd@ti.com,
 khilman@baylibre.com,
 rogerq@kernel.org,
 tony@atomide.com,
 robh@kernel.org,
 krzk+dt@kernel.org,
 conor+dt@kernel.org,
 richardcochran@gmail.com,
 aaro.koskinen@iki.fi,
 andreas@kemnade.info,
 andrew@lunn.ch,
 linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 danishanwar@ti.com,
 pratheesh@ti.com,
 j-rameshbabu@ti.com,
 praneeth@ti.com,
 srk@ti.com,
 rogerq@ti.com,
 krishna@couthit.com,
 mohan@couthit.com,
 pmohan@couthit.com,
 basharath@couthit.com,
 Murali Karicheri <m-karicheri2@ti.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3077F98-CC5C-4093-8319-CF45EECEAE4D@goldelico.com>
References: <20260105162546.1809714-1-parvathi@couthit.com>
 <20260105162546.1809714-3-parvathi@couthit.com>
To: Parvathi Pudi <parvathi@couthit.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

Hi,

> Am 05.01.2026 um 17:21 schrieb Parvathi Pudi <parvathi@couthit.com>:
>=20
> From: Roger Quadros <rogerq@ti.com>
>=20
> PRU-ICSS instance consists of two PRU cores along with various
> peripherals such as the Interrupt Controller (PRU_INTC), the =
Industrial
> Ethernet Peripheral(IEP), the Real Time Media Independent Interface
> controller (MII_RT), and the Enhanced Capture (eCAP) event module.
>=20

I am just wondering about the subject of this patch.

It reads as if general AM335x and AM437x support is introduced for the =
first time.
IMHO it should tell which subsystem/improvement is added.

BR and thanks,
Nikolaus
