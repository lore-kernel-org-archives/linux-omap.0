From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH v2 1/4] OMAP OPP: Add accessor function for getting OPP
 ID.
Date: Mon, 21 Dec 2009 12:41:33 +0530
Message-ID: <4B2F1FA5.4000009@ti.com>
References: <1261177539-15429-1-git-send-email-khilman@deeprootsystems.com> <1261177539-15429-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56227 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbZLUHLk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Dec 2009 02:11:40 -0500
In-Reply-To: <1261177539-15429-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>

Kevin,
        Some comments below:
Kevin Hilman wrote:
> Add new function opp_get_opp_id() for finding the OPP ID of a given
> OPP.  This allows us to further hide OPP layer details.
> 
> NOTE: OPP IDs are deprecated, and this function will eventually
>       be removed after all users of OPP IDs are removed.
Let us not add a deprecated function. If we are fixing this let us fix it right
the first time.
>  
> +u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
> +{
> +	return opp->opp_id;
> +}
> +
>  int opp_get_opp_count(struct omap_opp *oppl)
>  {
>  	u8 n = 0;

