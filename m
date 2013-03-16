From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 33/50] staging: omap-thermal: refactor APIs handling
 threshold values
Date: Sat, 16 Mar 2013 16:58:21 +0300
Message-ID: <20130316135821.GJ9189@mwanda>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
 <1363352438-15935-34-git-send-email-eduardo.valentin@ti.com>
 <20130316083952.GO9138@mwanda>
 <51446A50.9070701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51446A50.9070701@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 16, 2013 at 08:49:20AM -0400, Eduardo Valentin wrote:
> On 16-03-2013 04:39, Dan Carpenter wrote:
> >On Fri, Mar 15, 2013 at 09:00:21AM -0400, Eduardo Valentin wrote:
> >>  	if (ret) {
> >>  		dev_err(bg_ptr->dev, "failed to read thot\n");
> >>-		return -EIO;
> >>+		ret = -EIO;
> >>+		goto exit;
> >>  	}
> >>
> >>-	*thot = temp;
> >>+	*val = temp;
> >>
> >>+exit:
> >>  	return 0;
> >>  }
> >
> >
> >The bunny hop has introduced a bug and this always returns success.
> 
> What was the bug introduced?
> 
> I will send a patch to fix the return value.

Returning the wrong value *is* the bug.

regards,
dan carpenter

