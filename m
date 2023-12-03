Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC32AAA;
	Sun,  3 Dec 2023 13:16:13 -0800 (PST)
Received: from p200301077700c3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:c300:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1r9tot-006z7p-93; Sun, 03 Dec 2023 22:16:07 +0100
Date: Sun, 3 Dec 2023 22:16:05 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Lee Jones <lee@kernel.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 2/6] twl-core: add power off implementation for
 twl603x
Message-ID: <20231203221605.38496a8d@aktux>
In-Reply-To: <20231201104820.GC3259151@google.com>
References: <20231127221907.177442-1-andreas@kemnade.info>
	<20231127221907.177442-3-andreas@kemnade.info>
	<20231201104820.GC3259151@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Dec 2023 10:48:20 +0000
Lee Jones <lee@kernel.org> wrote:

> > +	if (err) {
> > +		pr_err("I2C error %d reading PHOENIX_DEV_ON\n", err);  
> 
> It would save an awful lot of lines and space if we could place these
> warnings/errors inside twl_i2c_read_u8().

Well, it is already in twl_i2c_read() ...
yes, we can save quite some lines.

Regards,
Andreas
