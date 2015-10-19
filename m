From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix oops with LPAE and more than 2GB of
 memory
Date: Mon, 19 Oct 2015 08:46:09 -0700
Message-ID: <20151019154609.GA22043@atomide.com>
References: <1444778000-22537-1-git-send-email-tony@atomide.com>
 <561DD014.10403@ti.com> <20151014160245.GA10113@atomide.com>
 <561F5C0C.6080106@ti.com> <20151015140551.GM10113@atomide.com>
 <561FC2E9.9050805@ti.com> <20151016192300.GD24370@atomide.com>
 <5624F692.5070302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5624F692.5070302@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <a0131933@ti.com>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, "Woodruff,
 Richard" <r-woodruff2@ti.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, Marek Belisko <marek@goldelico.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Lokesh Vutla <a0131933@ti.com> [151019 07:03]:
> 
> Since there is a big hole with in the memory space, we might also need
> to enable SPARSEMEM ?

No from what I remember that depends on section sizes and smaller
chunks of physical memory. For example, on the old Psions we had to
use DISCONTIGMEM/SPARSEMEM because of four discontiguous 8MB memory
chips.

Regards,

Tony
