From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 2/4] omap changes for ti81xx devices and minimal
 dra62x j5eco-evm support
Date: Tue, 22 Dec 2015 17:47:57 -0800
Message-ID: <20151223014756.GJ2793@atomide.com>
References: <567869f7.9440620a.dbdb.65d1SMTPIN_ADDED_BROKEN@mx.google.com>
 <20151222225331.GI30172@localhost>
 <20151222233343.GI2793@atomide.com>
 <CAOesGMjKaRcTHQ40p0pMUW-z1o9HZqEmon3fsFKe46QX82+gDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMjKaRcTHQ40p0pMUW-z1o9HZqEmon3fsFKe46QX82+gDA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap <linux-omap@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Olof Johansson <olof@lixom.net> [151222 15:41]:
> On Tue, Dec 22, 2015 at 3:33 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Olof Johansson <olof@lixom.net> [151222 14:58]:
> >>
> >> I'm a little puzzled by how you chose to organize this branch. We usually
> >> ask for SoC enablement and new DT files separately. Is there a reason you
> >> couldn't split out the SoC pieces and include those in the soc branch, and
> >> leave the DT contents for this one?
> >
> > Hmm yeah I guess I kept all the 81xx stuff in a single branch because of the
> > earlier largeish set of 81xx fixes that had interlaced dts and SoC changes
> > that had to be in a specific order to keep system booting because of bugs in
> > the dts defined clocks.
> >
> > If you want to, I can respin these patches into two branches, one for dts and
> > one for SoC changes. Probably both branches have to be based on the earlier
> > branch "omap-for-v4.5/81xx-fixes-signed" to avoid merge conflicts though.
> 
> Yeah, that sounds good. Please do.

OK updated pull requests sent. It's now three separate pull requests starting
with "[GIT PULL 1/3] reworked fix for earlier ti81xx changes for v4.5 merge
window".

Regards,

Tony
