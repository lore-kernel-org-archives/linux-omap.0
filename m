From: David Brownell <david-b@pacbell.net>
Subject: Re: Recent git kernels and OSK
Date: Mon, 2 Oct 2006 16:29:53 -0700
Message-ID: <200610021629.54459.david-b@pacbell.net>
References: <4521941B.2020102@balister.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <4521941B.2020102@balister.org>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Monday 02 October 2006 3:35 pm, Philip Balister wrote:
> I just built a kernel from today's git repo and tried booting it on my=20
> OSK. The boot hung after uncompressing the kernel at the "Starting=20
> kernel ..." message.

Even after enabling lowlevel debug, yes?


> Has anyone successfully booted a recent git kernel on the OSK?

=46rom OMAP git, no.

=46rom Linus' kernel.org git, yes ... albeit many drivers were missing.

=2D Dave
