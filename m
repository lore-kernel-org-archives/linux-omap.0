From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: OMAP: clock DT conversion issues with omap36xx
Date: Sat, 1 Feb 2014 19:55:53 +0100
Message-ID: <20140201185553.GB7125@mars>
References: <52E697C0.6000202@gmail.com>
 <1390848104.4936.62.camel@mars>
 <52E772A3.4090401@ti.com>
 <1390901735.2963.8.camel@lovely>
 <52E77D03.8090001@ti.com>
 <52E7B361.2030601@ti.com>
 <1390928565.4904.88.camel@mars>
 <1390994505.5023.32.camel@mars>
 <52E916BC.5040906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52E916BC.5040906@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, pavel@ucw.cz, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 29, 2014 at 04:57:00PM +0200, Tero Kristo wrote:
> 
> Hmm, well, the omap96m_alwon_fck rate is still wrong. Try adding
> ti,min-div = <2>; and ti,max-div = <4>; to properties of the clock
> node.

Hmm, doesn't change anything here.

Thanks
  -- Christoph
