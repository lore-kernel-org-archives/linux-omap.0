From: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] OMAP: Dereference of NULL autodep in _autodep_lookup()
Date: Sun, 14 Feb 2010 17:48:42 +0100
Message-ID: <4B78296A.10002@gmail.com>
References: <4B781E05.9040502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B781E05.9040502@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: paul@pwsan.com, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Op 14-02-10 17:00, Roel Kluin schreef:
> Don't dereference autodep when it's NULL. In _autodep_lookup() an
> ERR_PTR(-ENOENT) is assigned to autodep->pwrdm.ptr if pwrdm_lookup() fails.

I am not sure whether my patch was right, if indeed a dereference, then it
appears to also occur in _clkdm_add_autodeps() and _clkdm_del_autodeps().

Roel
