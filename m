From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
Date: Thu, 26 Oct 2017 00:34:12 +0300
Message-ID: <20171025213412.utdt46bh3tzrumcy@darkstar.musicnaut.iki.fi>
References: <20171025203459.GA22035@amd> <20171025212806.GA21504@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171025212806.GA21504@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: ivo.g.dimitrov.75@gmail.com, sakari.ailus@linux.intel.com, khilman@kernel.org, abcloriens@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, martijn@brixit.nl, filip.matijevic.pz@gmail.com, clayton@craftyguy.net, Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Oct 25, 2017 at 02:28:07PM -0700, Tony Lindgren wrote:
> Also try booting with mem=512M@0x80000000 or 256M or 768M. Maybe the
> memory is different size or partially broken?

Yeah, some early N950s may have only 512 MB.

A.
