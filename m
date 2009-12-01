From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 Switch between multiple displays
Date: Tue, 01 Dec 2009 11:45:28 +0200
Message-ID: <1259660728.14667.12.camel@tubuntu.research.nokia.com>
References: <1f11a5490911301126p1444f93dga1821a67479d0c7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:52185 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803AbZLAJps (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 04:45:48 -0500
In-Reply-To: <1f11a5490911301126p1444f93dga1821a67479d0c7e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ashwin Bihari <abihari@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, 2009-11-30 at 20:26 +0100, ext Ashwin Bihari wrote:
> My system is going to have to support multiple display panels and
> switch between them using runtime checks. I've got two displays
> currently registered and confirmed with:
> 
> # cat displays
> lcd e:1 u:1 t:0 h:480/2/2/41 v:272/2/6/10 p:10000 r:0 i:0
> lcd e:0 u:1 t:0 h:480/2/2/41 v:800/2/6/10 p:10000 r:0 i:0
> 
> Short of adding a new module parameter for me to key off the
> panel_name to make the choice, is there some other way already
> implemented for me to indicate which display the DSS2 system should
> use as the default display panel?

You are using an old version of DSS2. With later versions you can use
omapdss.def_disp kernel parameter (see DSS documentation), or
default_device field in omap_dss_board_info.

 Tomi


