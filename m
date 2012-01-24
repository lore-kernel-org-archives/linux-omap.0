From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH RFC 1/2] watchdog : omap_wdt : Implement
 WDIOC_GETBOOTSTATUS for omap3+
Date: Tue, 24 Jan 2012 06:29:01 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D12143317902D6@DBDE01.ent.ti.com>
References: <1327317188-14782-1-git-send-email-shubhrajyoti@ti.com>
 <1327317188-14782-2-git-send-email-shubhrajyoti@ti.com>
 <B5906170F1614E41A8A28DE3B8D12143317901B9@DBDE01.ent.ti.com>
 <CAM=Q2ctL_Z5P6=NwAWBHD2bR=xqHMCF15g6v0Ap=hJMPdgXwyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAM=Q2ctL_Z5P6=NwAWBHD2bR=xqHMCF15g6v0Ap=hJMPdgXwyQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Datta,
 Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Shubhrajyoti,

On Tue, Jan 24, 2012 at 11:40:43, Shubhrajyoti Datta wrote:
> Hi Vaibhav,
> 
> On Tue, Jan 24, 2012 at 10:32 AM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
> > On Mon, Jan 23, 2012 at 16:43:07, Datta, Shubhrajyoti wrote:
> >> This patch intends to implement the WDIOC_GETBOOTSTATUS ioctl
> >> for the omap3 and omap4.
> >>
> >
> > Instead of just returning the register content why not parse
> > the RSTST register value and check if it's really a watchdog
> > reset or not?
> 
> That is what is done for 24xx and below cpus. So I thought of extending it.
> 
> 

IMO they also need to be fixed then :)

Just returning the register content does not help much and looking at other
implementations, like Blackfin, I am guessing this IOCTL is supposed to give
a yes/no sort of result.

Regards,
Vaibhav B.
