From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] backlight: mark struct
	backlight_ops const
Date: Mon, 22 Feb 2010 14:35:27 -0500
Message-ID: <8bd0f97a1002221135n6c52a657i1817063d2664bfda@mail.gmail.com>
References: <20100221001049.2f63f5d6@neptune.home>
	<20100221001851.673db863@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100221001851.673db863-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Cc: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, dri-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-omap@vger.kernel.org

T24gU2F0LCBGZWIgMjAsIDIwMTAgYXQgMTg6MTgsIEJydW5vIFByw6ltb250IHdyb3RlOgo+IMKg
ZHJpdmVycy92aWRlby9iZjU0eC1scTA0M2ZiLmMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fCDCoCDCoDIgKy0KPiDCoGRyaXZlcnMvdmlkZW8vYmZpbi10MzUwbWNxYi1mYi5jIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfCDCoCDCoDIgKy0KCkFja2VkLWJ5OiBNaWtlIEZyeXNpbmdlciA8dmFw
aWVyQGdlbnRvby5vcmc+Ci1taWtlCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpEb3dubG9hZCBJbnRl
bCYjMTc0OyBQYXJhbGxlbCBTdHVkaW8gRXZhbApUcnkgdGhlIG5ldyBzb2Z0d2FyZSB0b29scyBm
b3IgeW91cnNlbGYuIFNwZWVkIGNvbXBpbGluZywgZmluZCBidWdzCnByb2FjdGl2ZWx5LCBhbmQg
ZmluZS10dW5lIGFwcGxpY2F0aW9ucyBmb3IgcGFyYWxsZWwgcGVyZm9ybWFuY2UuClNlZSB3aHkg
SW50ZWwgUGFyYWxsZWwgU3R1ZGlvIGdvdCBoaWdoIG1hcmtzIGR1cmluZyBiZXRhLgpodHRwOi8v
cC5zZi5uZXQvc2Z1L2ludGVsLXN3LWRldgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppYm0tYWNwaS1kZXZlbCBtYWlsaW5nIGxpc3QKaWJtLWFjcGktZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL2libS1hY3BpLWRldmVsCg==
