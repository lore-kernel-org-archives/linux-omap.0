Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABED314B9A;
	Tue, 24 Mar 2026 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355937; cv=none; b=LcNlORh1BSxRs9AYs3WjDxDxCkY0pf3pbDY5Jwt1rPFxYLW8sycfnDpICQ1q0Xdie1+FJxgkxiHtwSuWxbbCBIfoj7K0VRD6e+e2xR7u0lkrxXkMAhH3KHgne5oK1ND9pXqLUd/CwQeyD2Pad4z7jNaLk1DVJbg++KcWDOFSuF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355937; c=relaxed/simple;
	bh=n0h1AinUMAzmZCaro/6NFeRSXzDQyEyEdmYM2DZbM7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zns6BizFEunjr9tvOwga50N12+IJk2KHqXUPM3GNtB4FbrKGtWcJ6ruXt/pIwL1Abb4kF+8pldLC2C+Xm1VBPW7BI+VKzQORRyIKaqYQ3XbQ+UG23dr9gnaprhASV1+ntxt3tFXViEOEF6UVkDczxjgxjxpt9DjRYsgGzkh1aMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0vQskzlO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0vQskzlO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CIe/1Rs/fwVWVoErQ7DrPISOxhRMH4MZG/IidA4tHfs=; b=0vQskzlO/DTD0Wx4J/r0CToJDm
	vIGPrTTuufQIxhO3xeYfWRSWHWfEdLDCL4ZNVw7m8VU1Pb/2rw8HnBiiiRwBfWVvD0jkFOW0I5A0K
	VKWty3NmPxu62SFRnhBkgXxrYZO2By/U6VQ4wZaOeD/XScVisgug0vodM6fiNCfbptUo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w511q-00D654-ES; Tue, 24 Mar 2026 13:38:38 +0100
Date: Tue, 24 Mar 2026 13:38:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, nm <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, afd <afd@ti.com>,
	rogerq <rogerq@kernel.org>, tony <tony@atomide.com>,
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>,
	conor+dt <conor+dt@kernel.org>,
	richardcochran <richardcochran@gmail.com>,
	aaro koskinen <aaro.koskinen@iki.fi>,
	andreas <andreas@kemnade.info>,
	linux-omap <linux-omap@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>, danishanwar <danishanwar@ti.com>,
	pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>,
	praneeth <praneeth@ti.com>, srk <srk@ti.com>,
	rogerq <rogerq@ti.com>, m-malladi <m-malladi@ti.com>,
	krishna <krishna@couthit.com>, mohan <mohan@couthit.com>,
	pmohan <pmohan@couthit.com>, basharath <basharath@couthit.com>,
	Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH v5 3/3] arm: dts: ti: Add device tree support for
 PRU-ICSS on AM335x
Message-ID: <6c523569-928b-4df5-89f3-9a460d5f6020@lunn.ch>
References: <20260307122641.738450-1-parvathi@couthit.com>
 <20260307122641.738450-4-parvathi@couthit.com>
 <7ho6ks1r4s.fsf@baylibre.com>
 <91797572.667989.1773662409130.JavaMail.zimbra@couthit.local>
 <ee2ec279-ee5d-4d6d-b6ff-35187e3f03e6@kernel.org>
 <1868242922.724201.1774332140293.JavaMail.zimbra@couthit.local>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1868242922.724201.1774332140293.JavaMail.zimbra@couthit.local>

> We have verified that dtbs_check does report this issue, and we will update
> our test setup to retain full dtbs_check output to avoid missing such warnings
> in the future.

I would expect the exit value is set to something other than 0 when it
finds an error. Why not just fail the test based on that?

      Andrew
