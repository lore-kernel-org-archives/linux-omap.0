From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v3 2/3] iio:adc:palmas: add DT support
Date: Mon, 19 Oct 2015 13:57:31 +0200
Message-ID: <5624DAAB.9040207@metafoo.de>
References: <cover.1445000017.git.hns@goldelico.com> <79429ca1a6d0465b6b19ede16d90de23e4363431.1445000017.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <79429ca1a6d0465b6b19ede16d90de23e4363431.1445000017.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Pradeep Goudagunta <pgoudagunta-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 10/16/2015 02:53 PM, H. Nikolaus Schaller wrote:
[...]
> +Optional sub-nodes:
> +ti,channel0-current-microamp: Channel 0 current in uA.
> +	Values are rounded to derive 0uA, 5uA, 15uA, 20uA.
> +ti,channel3-current-microamp: Channel 3 current in uA.
> +	Valid are rounded to derive 0uA, 10uA, 400uA, 800uA.
> +ti,enable-extended-delay: Enable extended delay.

Those three above sound more like configuration policy, rather than hardware
description. What influence which values should be chosen?
