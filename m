From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V2] ARM: OMAP3+: PM: VP: ensure VP is idle before disable
Date: Mon, 21 May 2012 17:51:57 +0300
Message-ID: <20120521145157.GA7923@besouro>
References: <1337365122-702-1-git-send-email-nm@ti.com>
 <20120519095237.GA26761@besouro>
 <CAOMWX4f2N1dS8RcwYAyUpmWVKPkEHGuhMGGZ3__D-DwipsjzFQ@mail.gmail.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAOMWX4f2N1dS8RcwYAyUpmWVKPkEHGuhMGGZ3__D-DwipsjzFQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, eduardo.valentin@ti.com, Wenbiao Wang <wwang@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello,

On Mon, May 21, 2012 at 08:36:35AM -0500, ext Nishanth Menon wrote:
>  Sat, May 19, 2012 at 4:52 AM, Eduardo Valentin <eduardo.valentin@ti.com>
> wrote:
> >
> >
> > I guess it is time to properly document this increasing busy loop delay..
> > As it is getting closer to ms scale..
> Does the following sound good?
> /* Maximum time for Voltage Processor to enter or exit idle */

Sounds way better :-). If you have an estimation of how long it takes
in the average case, it might help. But I am OK already with the above,
in case you don't have the estimation.

> 
> Regards,
> Nishanth Menon

Cheers,

--
Eduardo Valentin
