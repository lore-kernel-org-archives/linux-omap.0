From: Raphael Assenat <raph@8d.com>
Subject: Criteria for merging new board support files
Date: Thu, 12 Jul 2012 16:47:10 -0400
Message-ID: <20120712204710.GA3850@renkinjitsu.usine.8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:42647 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932987Ab2GLVXz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jul 2012 17:23:55 -0400
Received: from raph.usine.8d.com ([192.168.142.55] helo=renkinjitsu.usine.8d.com)
	by roc.holo.8d.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <raph@8d.com>)
	id 1SpQI3-0000Rq-Dm
	for linux-omap@vger.kernel.org; Thu, 12 Jul 2012 16:47:12 -0400
Received: from raph by renkinjitsu.usine.8d.com with local (Exim 4.72)
	(envelope-from <raph@8d.com>)
	id 1SpQI2-0002Hl-Uv
	for linux-omap@vger.kernel.org; Thu, 12 Jul 2012 16:47:10 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

We have designed a board based on the AM3505 to use in one of our produ=
cts,
an unattended payment terminal. I am wondering if it would be meaningfu=
l=20
to clean up and submit our patches to add support for our board in the=20
mainline.

As this board is neither a development/evm platform nor a mass produced=
=20
consumer product, not many users, if ever, will want to customize
their kernel. Therefore I am not sure what the advantages for the=20
community at large would be... Besides our code serving as yet another=20
board file example.

What is the current maintainer position regarding new board support fil=
es?=20
Were submissions from people in the same situation ever merged? Do you =
think
it worth the effort to clean up and submit our board support files?

Best regards,
Rapha=EBl Ass=E9nat
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
