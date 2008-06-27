From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: camera isp driver status?
Date: Fri, 27 Jun 2008 09:58:39 +0300
Message-ID: <48648F9F.3010005@mm-sol.com>
References: <8bf247760806260739t36c2df75sc7fe7be74dd034@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([213.240.235.226]:43216 "EHLO extserv.mm-sol.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166AbYF0HEr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jun 2008 03:04:47 -0400
In-Reply-To: <8bf247760806260739t36c2df75sc7fe7be74dd034@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ram <vshrirama@gmail.com>
Cc: linux-omap@vger.kernel.org

Ram wrote:
> Hi,
>   What is the current status of the camera isp driver on OMAP3 processor?
>   I am using the linux-2.6.22 kernel on linux.omap.com. I am using the
> camera isp driver
>   that exists on 0.9.8 release. I have also tried 0.9.7 release.
> 
>   Has anybody tested it on ISP sensor  (ISP is within the sensor)
> connected through
>   parallel interface working? that is i am not using the ISP that
> exists on OMAP3.
> 
>   I am routing all the cam data to Memory through CCDC. Right now i am
>   using YUV422 format.
> 
>  I do see some  hsync issues. the image appears split at one the end.
>  some frames are good. On some frames the image is split at one of the edges.
> 
>  I also do notice that the first 5-6 frames are green.
>  I do notice that  the data is all jumbled up.
>  i notice only green lines in the images captured.
> 
> 
>  has anyone faced similar issues?
> 
> please do advice.
> 
> Regards,
> sriram
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


You can check in V4L mailing list there is new ISP driver from TI in RFC 
status.

I.Ivanov
