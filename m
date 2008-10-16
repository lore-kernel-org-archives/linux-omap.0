From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 01/04] OMAP3 SRF: Generic shared resource f/w
Date: Thu, 16 Oct 2008 11:27:40 -0700
Message-ID: <200810161127.41161.david-b@pacbell.net>
References: <022301c92f99$24a25550$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:41190 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752736AbYJPS1o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Oct 2008 14:27:44 -0400
In-Reply-To: <022301c92f99$24a25550$LocalHost@wipultra1382>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

On Thursday 16 October 2008, Rajendra Nayak wrote:
> +=A0=A0=A0=A0=A0=A0=A0/* Function to change the level of the resource=
 */
> +=A0=A0=A0=A0=A0=A0=A0int (*change_level)(struct shared_resource *res=
, u32 target_level);
> +=A0=A0=A0=A0=A0=A0=A0/* Function to validate the requested level of =
the resource */
> +=A0=A0=A0=A0=A0=A0=A0int (*validate_level)(struct shared_resource *r=
es, u32 target_level);

What is a "target_level" supposed to represent?  Are they
even comparable, in the senses that

  (a) "42" for one resource is the same as "42" for another?
  (b) "42" includes "41", "40", etc?

There's no documentation at all on what seems to be a
fairly fundamental concept.  Or on the rest of it either;
the call syntax information is no real help.  What kind
of "resource" is involved, that might need a "level"?

Also, I suspect a flat namespace for all resources will
be a net lose.  Why isn't it scoped by devices, so that
device-relative "logical names" can be used instead of
requiring what have tended to be platform-specific and
very mutable "physical names"?  I notice that the call
to request a resource is already device-scoped ...

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
