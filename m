From: "Ramesh Gupta Guntha" <grgupta77@gmail.com>
Subject: Re: new PM branch available
Date: Wed, 14 Jan 2009 18:10:26 +0530
Message-ID: <3a2dabf50901140440y12b8c874j4b0da8100c763c24@mail.gmail.com>
References: <87iqoij2me.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:30351 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbZANMk1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 07:40:27 -0500
Received: by rv-out-0506.google.com with SMTP id k40so509141rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 04:40:26 -0800 (PST)
In-Reply-To: <87iqoij2me.fsf@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

On 1/14/09, Kevin Hilman <khilman@deeprootsystems.com> wrote:
> Hello,
>
> The latest PM branch is now available[1].
>
> I've done basic testing of retention and off-mode (suspend and dynamic
> idle) on Beagle and custom HW.  My SDP has something still keeping
> CORE active that others have not seen, but I have yet to debug.  Any
> other reports from SDP testing would be appreciated.

I have tested on my SDP, I too observed the similar behaviour, I am
seeing both PER and CORE are active.

thanks
Ramesh Gupta G
