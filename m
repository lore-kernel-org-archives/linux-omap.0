From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: Command Time-Out values in MMC
Date: Sat, 28 Jan 2006 22:41:52 +0100
Message-ID: <fb249edb0601281341t2228cdect@mail.gmail.com>
References: <fb249edb0601281148g745d146cy@mail.gmail.com>
	<20060128203624.GD17374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060128203624.GD17374@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 28/01/06, Tony Lindgren <tony@atomide.com> wrote:
> As far as I remember we're not using the command timeout currently and it
> was expiring with some cards and causing false errors.
>

The value 0 could be used to disable timing out.
Andrzej Zaborowski
