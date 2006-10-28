From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: Re: [PATCH] OMAP MMC fixes
Date: Sat, 28 Oct 2006 20:40:09 +0200
Message-ID: <200610282040.09413.marek.vasut@gmail.com>
References: <200610282034.05218.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200610282034.05218.marek.vasut@gmail.com>
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

oops, sorry, I missed the previous patch ...

Dne sobota 28 =F8=EDjen 2006 20:34 jste napsal(a):
> Hi,
> omap mmc driver doesnt use data->blksz_bits anymore in 2619. It uses only
> data->blksz . Enclosed patch fixes it.
>
> Signed-off-by: Marek Va=B9ut <marek.vasut@gmail.com>
