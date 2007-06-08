From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: PROBLEMS WITH DNS
Date: Fri, 8 Jun 2007 20:39:38 +0100
Message-ID: <20070608193938.GB12975@flint.arm.linux.org.uk>
References: <c7af2a170706081023w25076e1eq4a791b02a977f9f@mail.gmail.com>
	<4669945F.5070708@mbdsys.com> <466997D9.7040909@grupopie.com>
	<4669A194.8090108@mbdsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <4669A194.8090108@mbdsys.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Vadim Lebedev <vadim@mbdsys.com>
Cc: linux-omap-open-source@linux.omap.com, Paulo Marques <pmarques@grupopie.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 08, 2007 at 08:36:04PM +0200, Vadim Lebedev wrote:
> Kernel mode dhcp client solutions allows muuch faster boot sequences...
> for embedded stuff 15-20 secs boot speed advantage is important....

Then complain to the user space dhcp client solutions; they can make
their implementation as fast as the kernel solution if they so wished.
There's nothing magic about the kernel dhcp client.
