From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH] Documentation: dt: bindings: TI WiLink modules
Date: Thu, 27 Jun 2013 16:19:08 +0300
Message-ID: <1372339148.8383.17.camel@cumari.coelho.fi>
References: <1372149330-24335-1-git-send-email-coelho@ti.com>
	 <51CBC1C8.1040301@gmail.com> <1372322851.18889.53.camel@cumari.coelho.fi>
	 <20130627125131.GA27285@kahuna> <1372337887.8383.12.camel@cumari.coelho.fi>
	 <CAGo_u6qbt9dANgKq49xR=1qsCpUBhmVaPL4EK04XvTw+=4Z23g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAGo_u6qbt9dANgKq49xR=1qsCpUBhmVaPL4EK04XvTw+=4Z23g@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: grant.likely@linaro.org, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2013-06-27 at 08:15 -0500, Nishanth Menon wrote:
> On Thu, Jun 27, 2013 at 7:58 AM, Luciano Coelho <coelho@ti.com> wrote:
> > For the actual DTS files, I could add a wilink.dtsi with enumerations
> > for these values so they could be used in the node definitions.  But I'm
> > not sure it's going to be that valuable in the end.
> The  way GPIO HIGH was defined might help to provide guidance I think :)

Where? As far as I can see, the GPIO flags are defined in a bitmap.

--
Luca.

