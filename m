From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/8] omap: Lock DPLL5 at boot
Date: Tue, 6 Oct 2009 09:19:10 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0910060918560.7395@utopia.booyaka.com>
References: <20091002223510.11962.21751.stgit@localhost>
	<20091002223859.11962.20369.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091002223859.11962.20369.stgit@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Anand Gadiyar <gadiyar@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 2 Oct 2009, Tony Lindgren wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> Lock DPLL5 at 120MHz at boot. The USBHOST 120MHz f-clock and
> USBTLL f-clock are the only users of this DPLL, and 120MHz is
> is the only recommended rate for these clocks.
> 
> With this patch, the 60 MHz ULPI clock is generated correctly.
> 
> Tested on an OMAP3430 SDP.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Signed-off-by: Paul Walmsley <paul@pwsan.com>


- Paul
