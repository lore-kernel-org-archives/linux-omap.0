From: David Brownell <david-b@pacbell.net>
Subject: Re: OMAP: small patch fixes "error: field 'gpio_expa' has
	incomplete type"
Date: Thu, 28 Dec 2006 12:04:50 -0800
Message-ID: <200612281204.50504.david-b@pacbell.net>
References: <25c21ceb0612271236ped35f6t65da0e66c86fcd9a@mail.gmail.com>
	<459376D4.707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <459376D4.707@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 27 December 2006 11:48 pm, Dirk Behme wrote:
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0INIT_WORK(&(omap_ir->pdat=
a->gpio_expa.work), NULL);

All of these patches need to be paired with code making callback
function use container_of() to convert the pointer though ... right?
