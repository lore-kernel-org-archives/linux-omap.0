From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH/RFC 1/2] Add Dspbridge driver to OMAP GIT kernel
Date: Wed, 18 Jun 2008 07:15:45 -0500
Message-ID: <8da36a32ba6843b87de7750ccfb59256@felipebalbi.com>
References: <A8E8DDC23969AE4CB38FFF51016C778202D975BA@dlee10.ent.ti.com> <ECC99C9B-90E9-4D91-9E74-7999D3868D20@student.utwente.nl> <A8E8DDC23969AE4CB38FFF51016C778202D97C48@dlee10.ent.ti.com> <20080618095252.GB29899@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [209.62.36.12] ([209.62.36.12]:54692 "EHLO
	serv01.siteground211.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753472AbYFRMPv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jun 2008 08:15:51 -0400
In-Reply-To: <20080618095252.GB29899@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Koen Kooi <k.kooi@student.utwente.nl>, linux-omap@vger.kernel.org, "Gupta, Ramesh" <grgupta@ti.com>



On Wed, 18 Jun 2008 12:52:53 +0300, Tony Lindgren <tony@atomide.com> wrote:
> In addition, read the following:
> 
> Documentation/CodingStyle
> Documentation/SubmittingDrivers
> Documentation/SubmittingPatches
> Documentation/SubmitChecklist
> 
> And then make sure scripts/checkpatch.pl will not produce errors or
> obvious warnings. Otherwise this code will just get ignored by people
> who should review the patches.

sparse would also be quite nice :-)

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

