Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="pjUVaZQw"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A86D10FF;
	Thu, 30 Nov 2023 04:05:55 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id C0C3B60513;
	Thu, 30 Nov 2023 12:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1701345954;
	bh=64j2ievVtQY927UUjwWzElwnhla7pdOyy4BEKWcOMUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pjUVaZQwu5nwPYHMTyThDrx+JB04YB91pHg6wpWf/HpaIoOSUdRFjGmci4jYiWlTC
	 eoIeXAMBN8HZvXqUNDqIORpTwmAUXqSXenV70SdCRRqCV1Lxpr6chRqctiH+nH7kY6
	 fcdCZoSeELD/Rd9LfnZgzD+WcS0cjLBYpeDVUu+/uvCUvcx+qj75Fdr6ADE1xB/PVz
	 bkWBGNXkoVS678+PUZG0rmeQjtYfsYaHRdn1olC0671fw5TfJar+imqWTOaZSyBw6E
	 0zHN5zEDFxSPU30QzjyhK8g+Xires0UTQ2fPE/2aauStsdhwYdZDfM0+pgGaxfaKFD
	 FYiZrtkoXSIEw==
Date: Thu, 30 Nov 2023 14:05:33 +0200
From: Tony Lindgren <tony@atomide.com>
To: Adam Ford <aford173@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: omap: logicpd-torpedo: do not disguise GNSS
 device
Message-ID: <20231130120533.GD5169@atomide.com>
References: <20231127200430.143231-1-andreas@kemnade.info>
 <CAHCN7xLpERbs1MPMXTAPCqoPgAN5ts+Ubr=MiO6urW-wuuxp=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xLpERbs1MPMXTAPCqoPgAN5ts+Ubr=MiO6urW-wuuxp=w@mail.gmail.com>

* Adam Ford <aford173@gmail.com> [231127 20:40]:
> On Mon, Nov 27, 2023 at 2:04 PM Andreas Kemnade <andreas@kemnade.info> wrote:
> >
> > https://support.logicpd.com/DesktopModules/Bring2mind/DMX/Download.aspx?portalid=0&EntryId=649
> > clearly specifies the availability of GPS, so let's not disguise it
> > and name the node accordingly.
> 
> Thanks for doing this.

Applying into omap-for-v6.8/dt thanks.

Tony
