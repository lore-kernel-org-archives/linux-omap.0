Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466403CB8F5;
	Sun, 18 Oct 2026 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792305718; cv=none; b=XNIUaeIsFOwAnOYSRoEKBEy72YRNXbct/qZfg4cCZQC8ldVJpxvlPOyYT1cs0lOa4Ok+ZTrFULItbYk3y1aM8Aj6LzXj7V8tJDhJTkEJKb0giTErtvnlRGj9YCSSBu5Xz+G4G63lAKlQH+V8Hz85/FMko3s87A0SB8fl1968D+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792305718; c=relaxed/simple;
	bh=rs5ZHwE3LsmfIanNp+/BzRrIaCnPTb7maIaogFzNqXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBYdrqm+IogoUsQtvXpg6mCBuz+6yhwdsrX32uOMfIhuUVobFh8iYPqI6SSadaH1dCwUlmcaz7WI34xXfixyiwSeb5g41IfrMHL/MfkWhLgNkOVjLxeNTVQae8mH1Wi8Nkq6JOpcWW3oKhMROyikdC5KSV5pd2rWa+QwFWtmQ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1mwKXegi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1mwKXegi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5327F1F000C4;
	Sun, 18 Oct 2026 06:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792305716;
	bh=A4xXl+sehu91x+nUAj2UWN80XDpdbu0ZTl7Uc0bSKgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1mwKXegihC7AZN6aPtbv47zcil/pTBahIl5PTeCLuKc3m6IteOFh612J5AAgmVhVD
	 OnIJwlE/St0KKUPGsE7aF/jJISHqySQCtcV0JOQLNmJaHxfIHyCCKg0+lTtYiNpiCB
	 b6OPQUEkHC+7PqbS3I0vEgXgfLII2LSMm+3ujX5Y=
Date: Sun, 18 Oct 2026 08:41:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: m-amirpour <ampr.mhd@gmail.com>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ohci-omap: handle root hub overcurrent
Message-ID: <2026101840-starch-blaspheme-0e4a@gregkh>
References: <20261018015747.246611-1-ampr.mhd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018015747.246611-1-ampr.mhd@gmail.com>

On Sun, Oct 18, 2026 at 05:27:47AM +0330, m-amirpour wrote:
> Handle overcurrent GPIO interrupts, disable port power when
> overcurrent is detected, and report the status through the
> root hub port status.
> 
> Signed-off-by: m-amirpour <ampr.mhd@gmail.com>
> ---
>  drivers/usb/host/ohci-omap.c | 212 +++++++++++++++++++++++++++++++----
>  1 file changed, 191 insertions(+), 21 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
