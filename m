From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/3] ARM: OMAP: TI814X: Create board support and
	enable build for TI8148 EVM
Date: Thu, 6 Oct 2011 12:17:27 -0700
Message-ID: <20111006191727.GK6324@atomide.com>
References: <1317258570-30494-1-git-send-email-hemantp@ti.com>
	<4E88542B.4010206@compulab.co.il>
	<2A3DCF3DA181AD40BDE86A3150B27B6B03B4EC5D52@dbde02.ent.ti.com>
	<4E8ACB3C.6020401@compulab.co.il>
	<2A3DCF3DA181AD40BDE86A3150B27B6B03B4EC6066@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4EC6066@dbde02.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Igor Grinberg <grinberg@compulab.co.il>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Pedanekar, Hemant <hemantp@ti.com> [111004 02:07]:
> Igor Grinberg wrote on Tuesday, October 04, 2011 2:31 PM:
> 
> > On 10/03/11 18:45, Pedanekar, Hemant wrote:
> >> Hi Igor,
> >> 
> >> Igor Grinberg wrote on Sunday, October 02, 2011 5:38 PM:
> >> 
> >>> Hi Hemant,
> >>> 
> >>> On 09/29/11 04:09, Hemant Pedanekar wrote:
> >>>> This patch adds minimal support and build configuration for TI8148 EVM.
> >>>> Also adds support for low level debugging on UART1 console on the EVM.
> >>>> 
> >>>> Note that existing TI8168 EVM file (board-ti8168evm.c) is updated with
> >>>> machine info for TI8148 EVM and renamed as board-ti81xxevm.c.
> >>> 
> >>> Should we really rename the existing file?
> >>> Shouldn't we just stick to the name of the file submitted first?
> >>> (e.g. board-ti8168evm.c) and just add the support for the new
> >>> TI8148 EVM in to the existing file?
> >> 
> >> But won't this be misleading?
> > 
> > Misleading? For whom?
> > Actually, I don't really care how you call that file.
> > What I care (and I think not just me) is uniformity, so
> > if we decide to rename all those files that have multiple
> > boards supported in them, I'm fine with it.
> > 
> > So pros for my proposed approach would be:
> > 1) Currently, there are already board files with multiple boards
> >    supported in them that follow the approach and renaming them is   
> > really unnecessary. 2) git log will not break.
> > 3) boards that cannot be named after the convention like 81xx
> >    but can be added to the same file will not require further renaming
> >    (like 82x8 - I don't really know if that will exist, just wondering).
> > 4) This renaming is really what Linus likes ;)
> > 
> > cons:
> > 1) Misleading?
> > 
> > Currently, I don't think this renaming is good for anything,
> > especially that majority of the board stuff should be transformed
> > to the DT descriptors.
> 
> Igor,
> I agree on the DT part and also understand the "pros" you mentioned.
> 
> I can submit the v4 of patches with TI8148 EVM support added in exisitng
> board-ti8168evm.c.
> 
> Tony, 
> Are you OK with the above approach?

Yes, let's not do renaming unless it's really needed. We'll be getting
rid of the board-*.c files anyways with device tree. So let's consider
the board-*.c files to be in minimal maintenance mode until they will
eventually get removed.

Regards,

Tony
