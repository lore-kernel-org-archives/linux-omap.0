From: Belisko Marek <marek.belisko@gmail.com>
Subject: eac and mcbsp for omap850
Date: Tue, 8 Dec 2009 13:06:05 +0100
Message-ID: <e7c6a05e0912080406y763b2e99nd0188ff1911ec829@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:63623 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbZLHMF6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 07:05:58 -0500
Received: by iwn1 with SMTP id 1so3698149iwn.33
        for <linux-omap@vger.kernel.org>; Tue, 08 Dec 2009 04:06:05 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I would like to rewrite old eac audio driver for omap730 to current
ASoc implementation
but as I can understand new implementation use McBsP to
transfer data to codec. Could this approach be used in omap850 which
use EAC like codec and data from memory is transfered via DMA?

Thanks in advance,

Marek
